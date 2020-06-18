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
}

# include: "order_items.explore.lkml"
#
# view: user_order_facts {
#   derived_table: {
#     explore_source: order_items {
#       column: user_id {field: order_items.user_id}
#       column: sale_price {field: order_items.sale_price}
#       column: created_at {field: order_items.created_at}
#     }
#
#   }
#   dimension: user_id {}
#   dimension: lifetime_orders {
#     type: number
#   }
#   dimension: lifetime_customer_value {type: number}
# }
