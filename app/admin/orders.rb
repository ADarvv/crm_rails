ActiveAdmin.register Order do
  permit_params :status

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :status do |order|
      order.status.humanize
    end
    column :total_amount do |order|
      "$#{order.total_amount}"
    end
    column :created_at
    actions
  end

  filter :email
  filter :status, as: :select, collection: Order.statuses.keys.map { |key| [key.humanize, key] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Order.statuses.keys.map { |key| [key.humanize, key] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :address
      row :city
      row :province
      row :postal_code
      row :status do |order|
        order.status.humanize
      end
      row :total_amount do |order|
        "$#{order.total_amount}"
      end
      row :created_at
      row :updated_at
    end
    
    panel "Order Items" do
      table_for resource.order_items do
        column :product do |item|
          link_to item.product.name, admin_product_path(item.product)
        end
        column :quantity
        column :price_at_time do |item|
          "$#{item.price_at_time}"
        end
        column :total_price do |item|
          "$#{item.total_price}"
        end
      end
    end
  end
end