connection: "looker-private-demo"

include: "/302_views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: campaigns {}

explore: order_items {
  fields: [
    ALL_FIELDS*,
    -order_items.inventory_item_id,
    -inventory_items.product_id,
  ]
  join: inventory_items {
    relationship: one_to_one
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  }
  join: distribution_centers {
    relationship: many_to_one
    sql_on: ${inventory_items.product_distribution_center_id = ${distribution_centers.id} ;;
  }
  join: users {
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
}



# explore: Customers {
#   from: order_items
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${Customers.user_id} ;;
#   }
# }
# The Order Items Explore is where analysts will go to find detailed order information.
# he Customers Explore will not be as detailed and will instead focus on user behavior and attributes.
