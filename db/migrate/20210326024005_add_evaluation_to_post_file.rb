class AddEvaluationToPostFile < ActiveRecord::Migration[5.2]
  def change
    add_column :post_files, :evaluation, :float
  end
end
