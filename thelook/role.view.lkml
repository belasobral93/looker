view: role {
  sql_table_name: saleseng.role ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: built_in {
    type: yesno
    sql: ${TABLE}.built_in ;;
  }

  dimension: embed {
    type: yesno
    sql: ${TABLE}.embed ;;
  }

  dimension: model_set_id {
    type: number
    sql: ${TABLE}.model_set_id ;;
  }

  dimension: models {
    type: string
    sql: ${TABLE}.models ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: permission_set_id {
    type: number
    sql: ${TABLE}.permission_set_id ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.permissions ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
