ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :active, 
                category_ids: [], images: []

  index do
    selectable_column
    id_column
    column :name
    column :price do |product|
      product.formatted_price
    end
    column :stock_quantity
    column :active do |product|
      product.active? ? "Active" : "Inactive"
    end
    column :categories do |product|
      product.categories.map(&:name).join(", ")
    end
    column :created_at
    actions
  end

  # Remove the problematic active filter entirely
  filter :name
  filter :price
  filter :stock_quantity
  filter :categories
  filter :created_at

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description, as: :text
      f.input :price, min: 0.01, step: 0.01
      f.input :stock_quantity
      f.input :active
    end
    
    f.inputs "Categories" do
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    
    f.inputs "Images" do
      f.input :images, as: :file, input_html: { multiple: true }
    end
    
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price do |product|
        product.formatted_price
      end
      row :stock_quantity
      row :active do |product|
        product.active? ? "Active" : "Inactive"
      end
      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end
      row :created_at
      row :updated_at
    end
    
    panel "Images" do
      if resource.images.attached?
        resource.images.each do |image|
          div do
            image_tag url_for(image), style: "max-width: 200px; margin: 10px;"
          end
        end
      else
        "No images uploaded"
      end
    end
  end
end