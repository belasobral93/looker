view: bsandell {
  sql_table_name: public.bsandell ;;

  dimension: car_id {
    type: number
    sql: ${TABLE}.car_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      minute15
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: number_of_pit_crew_members {
    type: number
    sql: ${TABLE}.number_of_pit_crew_members ;;
  }

  dimension: pitstop_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.pitstop_id ;;
  }

  dimension: racer_id {
    type: number
    sql: ${TABLE}.racer_id ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension_group: in_pit {
    type: duration
    intervals: [second, minute, hour]
    sql_start: ${start_raw} ;;
    sql_end: ${end_raw};;
  }

 measure: avg_minutes_in_pit {
    type: average
    sql: ${minutes_in_pit} ;;
  }

  measure: avg_seconds_in_pit {
    type: average
    sql: ${seconds_in_pit} ;;
  }


# dimension_group: race {
#   type: duration
#   intervals: [second, minute, hour]
#   sql_start: MIN(${start_raw}) ;;
#   sql_end: MAX(${end_raw});;
# }


  measure: count {
    type: count
    drill_fields: []
  }
}
