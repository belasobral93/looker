include: "/bela_orders.model.lkml"
view: bsandell_facts {
  derived_table: {
    explore_source: bsandell {
      column: pitstop_id {field: bsandell.pitstop_id}
      column: racer_id {field: bsandell.racer_id}
      column: pitstop_id {field: bsandell.pitstop_id}
      column: start_time {field: bsandell.start_time}
      column: duration {field: bsandell.seconds_in_pit}
      derived_column: pit_stop_rank {
        sql: RANK() OVER(PARTITION BY racer_id ORDER BY start_time) ;;
      }
      derived_column: pitstop_duration_diff {
        sql: duration - lag(duration,1) OVER (PARTITION BY racer_id ORDER BY racer_id, start_time) ;;
      }
    }
  }

#   SELECT racer_id,start_time, start_time - lag(start_time,1) OVER (PARTITION BY racer_id ORDER BY racer_id,start_time) FROM public.bsandell


  dimension: pitstop_id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.pitstop_id ;;
  }

  dimension: racer_id {
    hidden: yes
    sql: ${TABLE}.racer_id ;;
  }

  dimension: pit_stop_rank {
    type: number
    sql: ${TABLE}.pit_stop_rank ;;
  }

  dimension: pitstop_duration_diff {
    sql: ${TABLE}.pitstop_duration_diff ;;
  }

  measure: sum_pit_stop_duration_diff {
    type: sum
    value_format_name: decimal_2
    sql: ${pitstop_duration_diff} ;;
  }

  measure: avg_pit_stop_duration_diff {
    type: average
    sql: 1.00*${pitstop_duration_diff} ;;
  }


}
