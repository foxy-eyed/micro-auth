# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:sessions) do
      primary_key :id, type: :Bignum

      foreign_key :user_id, :users, type: :Bignum, null: false, index: true
      column :uuid, "uuid", null: false, index: true
      column :created_at, "timestamp(6) without time zone", null: false
      column :updated_at, "timestamp(6) without time zone", null: false
    end
  end

  down do
    drop_table(:sessions)
  end
end
