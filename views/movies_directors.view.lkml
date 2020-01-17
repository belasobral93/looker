view: movies_directors {
  sql_table_name: imdb_ijs.movies_directors ;;

  dimension: director_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.director_id ;;
  }

  dimension: movie_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  measure: count {
    type: count
    drill_fields: [directors.id, directors.first_name, directors.last_name, movies.id, movies.name]
  }
}
