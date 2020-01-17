view: roles {
  sql_table_name: imdb_ijs.roles ;;

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.actor_id ;;
  }

  dimension: movie_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  measure: count {
    type: count
    drill_fields: [actors.id, actors.first_name, actors.last_name, movies.id, movies.name]
  }
}
