local get_bitbucket_server_type_url = function(url_data)
    local is_user, project_or_user, repo = url_data.repo:match('scm/(~?)(.*)/(.*)')

    return table.concat {
        require"gitlinker.hosts".get_base_https_url(url_data),
        is_user and 'users/' or 'projects/',
        project_or_user,
        '/repos/',
        repo,
        '/browse/',
        url_data.file,
        '?at=',
        url_data.rev,
        url_data.lstart and table.concat { '#', url_data.lstart },
        url_data.lend and table.concat { '-', url_data.lend }
    }
end

require"gitlinker".setup {
    opts = { mappings = "<leader>gy" },
    callbacks = { ['git.acronis.com'] = get_bitbucket_server_type_url }
}
