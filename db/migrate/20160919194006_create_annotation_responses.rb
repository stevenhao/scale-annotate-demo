class CreateAnnotationResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :annotation_responses do |t|
      t.references :annotation_request, index: true, unique: true
      t.text :api_response
      t.timestamps
    end
  end
end
