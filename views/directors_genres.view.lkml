view: directors_genres {
  sql_table_name: imdb_ijs.directors_genres ;;

  dimension: director_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.director_id ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: prob {
    type: number
    sql: ${TABLE}.prob ;;
  }

  measure: count {
    type: count
    drill_fields: [directors.id, directors.first_name, directors.last_name]
  }
}
