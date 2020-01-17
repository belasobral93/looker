connection: "imbd"

# include all the views
include: "/views/**/*.view"

datagroup: movies_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: movies_default_datagroup

explore: actors {
  join: roles {
    type: left_outer
    sql_on: ${actors.id} = ${roles.actor_id} ;;
    relationship: one_to_many
  }
}

explore: directors {}

explore: directors_genres {
  join: directors {
    type: left_outer
    sql_on: ${directors_genres.director_id} = ${directors.id} ;;
    relationship: many_to_one
  }
}

explore: movies {}

explore: movies_directors {
  join: directors {
    type: left_outer
    sql_on: ${movies_directors.director_id} = ${directors.id} ;;
    relationship: many_to_one
  }

  join: movies {
    type: left_outer
    sql_on: ${movies_directors.movie_id} = ${movies.id} ;;
    relationship: many_to_one
  }
}

explore: movies_genres {
  join: movies {
    type: left_outer
    sql_on: ${movies_genres.movie_id} = ${movies.id} ;;
    relationship: many_to_one
  }
}

explore: roles {
  join: actors {
    type: left_outer
    sql_on: ${roles.actor_id} = ${actors.id} ;;
    relationship: many_to_one
  }

  join: movies {
    type: left_outer
    sql_on: ${roles.movie_id} = ${movies.id} ;;
    relationship: many_to_one
  }
}
