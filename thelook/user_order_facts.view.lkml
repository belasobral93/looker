view: user_order_facts {
  derived_table: {
    sql:
      SELECT
        user_id
        , COUNT(DISTINCT order_id) AS lifetime_orders
        , SUM(sale_price) AS lifetime_revenue
        , MIN(NULLIF(created_at,0)) AS first_order
        , MAX(NULLIF(created_at,0)) AS latest_order
        , COUNT(DISTINCT DATE_TRUNC('month', NULLIF(created_at,0))) AS number_of_distinct_months_with_orders
      FROM order_items
      GROUP BY user_id
       ;;

  }

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: first_order {
    type: date
    sql: ${TABLE}.first_order ;;
  }

  dimension: latest_order {
    type: date
    sql: ${TABLE}.latest_order ;;
  }

  dimension: days_as_customer {
    type: number
    sql: DATEDIFF('day', ${first_order}, ${latest_order})+1 ;;
  }

}
