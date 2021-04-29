
while getopts u:n: opt; do case "${opt}" in
u) original_owner=${OPTARG};; # required
n) repo_name=${OPTARG};; # required
esac done

if [ -z $original_owner ]; then echo "Specify the host's username, use '-u <user>'"; exit; fi
if [ -z $repo_name ]; then repo_name="Specify the repository's name, use '-n <repo name>'"; exit; fi


data=$(curl -sH "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${original_owner}/${repo_name}/forks)

rm -rf results # clean-up previous

for row in $(echo "${data}" | jq -r '.[] | @base64'); do

    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }

    url=$(_jq '.clone_url')
    login=$(_jq '.owner.login')

    mkdir -p results/${login} && cd $_

    git clone $url repo -q
    python3 -m pytest > test_results

    
    echo $login
    tail test_results -n 1 | grep -o "[^=]*"
    echo

    cd ../..
    
done
