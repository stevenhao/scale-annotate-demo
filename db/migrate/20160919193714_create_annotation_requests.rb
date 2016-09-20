class CreateAnnotationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :annotation_requests, id: :uuid do |t|
      t.text :labels
      t.attachment :image
      t.string :task_id, index: true
      t.timestamps
    end
  end
end
