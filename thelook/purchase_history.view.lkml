view: purchase_history {
  derived_table: {
    explore_source: order_items {
      column: user_id {field: order_items.user_id}
      column: order_id {field: order_items.order_id}
      column: created_at {field: order_items.created_date}
      column: order_total {field: order_items.total_sale_price}
      derived_column: purchase_order {
        sql: ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at) ;;
      }
      derived_column: running_order_total {
        sql: SUM(order_total) OVER (PARTITION BY user_id ORDER BY created_at ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ;;
      }
    }
  }

  dimension: user_id {type:number}
  dimension: order_id {type:number}
  dimension: created_at {}
  dimension: order_total {type:number}
  dimension: purchase_order {type:number}
  dimension: running_order_total {
    type: number

    }

#   measure: order_total {
#     type: sum
#     sql: ${sale_price} ;;
#   }
#   measure: running_order_total {
#     type: running_total
#     sql: ${order_total} ;;
#   }

  measure: first_purchase_order {
    type: min
    sql: ${purchase_order} ;;
  }
}

# If necessary, uncomment the line below to include explore_source.
# include: "bela_orders.model.lkml"

view: median_purchase_order {
  derived_table: {
    explore_source: purchase_history {
      column: user_id {}
      column: first_purchase_order  { }
      filters: {
        field: purchase_history.running_order_total
        value: ">=300"
      }
    }
  }
  dimension: user_id {
    type: number
  }

  dimension: first_purchase_order {
    type:number
  }

  measure: median_purchase_order {
    type: median
    sql: ${first_purchase_order} ;;
  }
}
