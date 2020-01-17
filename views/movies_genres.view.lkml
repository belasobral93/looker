view: movies_genres {
  sql_table_name: imdb_ijs.movies_genres ;;

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: movie_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  measure: count {
    type: count
    drill_fields: [movies.id, movies.name]
  }
}
