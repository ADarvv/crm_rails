ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name,
                :address, :city, :province, :postal_code

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :city
    column :province
    column :created_at
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :city
  filter :province
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
    end
    
    f.inputs "Address" do
      f.input :address, as: :text
      f.input :city
      f.input :province
      f.input :postal_code
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
      row :created_at
      row :updated_at
    end
    
    panel "Orders" do
      table_for resource.orders do
        column :id do |order|
          link_to order.id, admin_order_path(order)
        end
        column :status
        column :total_amount do |order|
          "$#{order.total_amount}"
        end
        column :created_at
      end
    end
  end
end