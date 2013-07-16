ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :name
    column :email
    column "Country",:country
    default_actions
  end
  batch_action :edit do |selection|
    render "bulk_edit", locals: {selected: selection}
  end

  collection_action :bulk_edit, method: :post do
    user_ids = params[:user_ids]
    user_attributes = params[:user]
    user_ids.split(' ').each { |id|
       User.where({id: id}).update_all(user_attributes)
    }
    redirect_to admin_users_path
  end
end



