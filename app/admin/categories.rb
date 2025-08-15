ActiveAdmin.register Category do
  permit_params :name, :description, :image

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :product_count
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :text
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :product_count
      row :created_at
      row :updated_at
      row :image do |category|
        if category.image.attached?
          image_tag url_for(category.image), style: "max-width: 200px;"
        end
      end
    end
    
    panel "Products in this Category" do
      table_for resource.products do
        column :name do |product|
          link_to product.name, admin_product_path(product)
        end
        column :price do |product|
          product.formatted_price
        end
        column :stock_quantity
      end
    end
  end
end