class CreateSinhviens < ActiveRecord::Migration[5.0]
  def change
    create_table :sinhviens do |t|
      t.string :masinhvien
      t.string :tensinhvien
      t.string :ngaysinh
      t.string :email
      t.string :trangthai
      t.references :lopsinhvien, foreign_key: true
      t.references :user, foreign_key: true      
    end
  end
end
