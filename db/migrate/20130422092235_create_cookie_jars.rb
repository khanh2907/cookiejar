class CreateCookieJars < ActiveRecord::Migration
  def change
    create_table :cookie_jars do |t|
      t.integer :level

      t.timestamps
    end
  end
end
