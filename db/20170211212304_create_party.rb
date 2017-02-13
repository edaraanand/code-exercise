class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer   :id
      t.string    :host_name
      t.string    :host_email
      t.integer   :numgsts
      t.text      :guest_names
      t.string    :venue
      t.string    :location
      t.string    :theme
      t.datetime  :when
      t.datetime  :when_its_over
      t.text      :descript
    end
  end
end

