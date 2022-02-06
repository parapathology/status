# https://www.r-bloggers.com/2021/07/cleaning-up-forked-github-repositories-with-gh/
# library("gh")
# library("magrittr")

# my_username <-  "sbalci"



# user_info <- gh::gh('GET /user',
#                       user = my_username
# )

my_username <-  owner

my_repos1 = gh("GET /users/:owner/repos",
              owner = my_username,
              page = 1,
              per_page = 100)

my_repos2 = gh("GET /users/:owner/repos",
               owner = my_username,
               page = 2,
               per_page = 100)

my_repos3 = gh("GET /users/:owner/repos",
               owner = my_username,
               page = 3,
               per_page = 100)

my_repos <- c(my_repos1,
              my_repos2,
              my_repos3)

forked_repos <-
  purrr::map_dfr(
    .x = my_repos,
    .f = ~unlist(.x)) %>%
  dplyr::filter(fork == "TRUE")


forked_repos_df <- forked_repos %>%
  select(name, html_url)



# forked_repos_name <- forked_repos[["name"]]
#
#
# purrr::map_dfr(
#   .x = forked_repos_name,
#   .f = ~ gh::gh('GET /repos/{owner}/{repo}',
#        owner = my_username,
#        repo = .x
# )[["parent"]][["full_name"]]
# )
#
#
# forked_repos_list <- NULL
#
# forked_repos_list <- as.data.frame(forked_repos_list)
#
# forked_repos_list[["reponame"]] <- NULL
#
# forked_repos_list[["repohtml"]] <- NULL
#
# for (i in 1:length(forked_repos_name)){
#
# user_repos <- gh::gh('GET /repos/{owner}/{repo}',
#                      owner = my_username,
#                      repo = forked_repos_name[i]
# )
#
# forked_repos_list[[i, "reponame"]] <- user_repos[["parent"]][["full_name"]]
#
# forked_repos_list[[i, "repohtml"]] <- user_repos[["parent"]][["html_url"]]
#
# return(forked_repos_list)
#
# }

