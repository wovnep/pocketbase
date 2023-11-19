module.exports = async ({github, context, core}) => {
    const commit = await github.rest.repos.getLatestRelease({
        owner: "pocketbase",
        repo: "pocketbase",
    })
    core.exportVariable('author', commit.data.commit.author.email)
}