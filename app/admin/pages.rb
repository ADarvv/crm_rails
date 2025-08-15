ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, hint: "URL-friendly version (e.g., 'about', 'contact')"
      f.input :content, as: :text, input_html: { rows: 10 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        simple_format(page.content)
      end
      row :created_at
      row :updated_at
    end
  end
end