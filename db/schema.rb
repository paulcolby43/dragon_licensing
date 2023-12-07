# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_09_192904) do

  create_table "AccountActivity", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.uuid "AccountHeadId", null: false
    t.datetime "DateCreated"
    t.string "LastBuyTransactionNumber", limit: 50
    t.string "LastContractNumber", limit: 50
    t.string "LastShipmentNumber", limit: 50
    t.string "LastPackNumber", limit: 50
    t.string "LastWorkOrderNumber", limit: 50
    t.integer "NumberOfComputers"
    t.varchar "SoftwareVersion", limit: 50
    t.index ["AccountHeadId"], name: "IX_AccountActivity_AccountHeadId"
  end

  create_table "AccountHead", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.text "AccountNumber"
    t.boolean "ScrapDragonClassic", null: false
    t.boolean "ScrapDragonX", null: false
    t.text "Address", null: false
    t.text "City", null: false
    t.text "State", null: false
    t.text "Address2", null: false
    t.text "Zip", null: false
    t.text "PhoneNumber", null: false
    t.text "YardName", null: false
    t.boolean "IsActive", default: true, null: false
    t.text "Notes"
    t.boolean "IsSuspended", default: false, null: false
  end

  create_table "CallDetail", primary_key: "Id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "CallHeadId", null: false
    t.uuid "ContactId", null: false
    t.text "Action", null: false
    t.string "UserName", limit: 50, null: false
    t.datetime "DateTimeStarted", null: false
    t.datetime "DateTimeSaved"
    t.index ["CallHeadId"], name: "IX_CallDetail_Callheadid"
  end

  create_table "CallHead", primary_key: "Id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "AccountHeadId", null: false
    t.uuid "CallTypeId", null: false
    t.bigint "TicketNumber", null: false
    t.uuid "ComputerTypeId", null: false
    t.boolean "IsScrapDragon", default: false, null: false
    t.boolean "IsJpegger", default: false, null: false
    t.boolean "IsEzcash", default: false, null: false
    t.boolean "IsClosed", default: false, null: false
    t.varchar_max "IssueDescription", null: false
    t.datetime "OpenDate", null: false
    t.datetime "CloseDate"
    t.uuid "EmployeeId"
  end

  create_table "CallType", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.string "Description", limit: 50, null: false
    t.boolean "IsBillable", default: false, null: false
    t.integer "DisplayOrder", default: 0, null: false
  end

  create_table "ComputerType", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.string "Description", limit: 50, null: false
    t.integer "DisplayOrder", default: 0, null: false
  end

  create_table "Contact", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.text "CompanyName", null: false
    t.text "Address", null: false
    t.text "Address2", null: false
    t.text "City", null: false
    t.nchar "State", limit: 10, null: false
    t.nchar "Zip", limit: 10, null: false
    t.text "ContactPerson", null: false
    t.string "PhoneNumber", limit: 50, null: false
    t.text "ContactDescription", null: false
    t.boolean "IsMainContact", default: false, null: false
  end

  create_table "ContactAccountRelatedCompanyXlink", primary_key: "Id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "AccountHeadId", null: false
    t.uuid "ContactId"
    t.uuid "RelatedCompanyId"
  end

  create_table "DemoId", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.text "Description"
    t.boolean "Active", null: false
    t.integer "DemoDays", default: 0, null: false
  end

  create_table "Employee", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.string "FirstName", limit: 50, null: false
    t.string "LastName", limit: 50, null: false
    t.string "Email", limit: 100
    t.boolean "IsActive", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
  end

  create_table "License", primary_key: "Id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "SoftwareVersionId", null: false
    t.uuid "AccountHeadId", null: false
    t.date "ExpireDate", null: false
    t.integer "DaysBetweenUpdate", null: false
    t.boolean "AutoUpdate", null: false
    t.boolean "IsDemoLicense", null: false
    t.boolean "IsSingleUser", null: false
  end

  create_table "NextAccountNumber", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.integer "NextNumber", null: false
  end

  create_table "NextTicketNumber", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.bigint "NextNumber", null: false
  end

  create_table "RelatedCompanyId", primary_key: "Id", id: :uuid, default: nil, force: :cascade do |t|
    t.text "CompanyName", null: false
  end

  create_table "SoftwareVersion", primary_key: "Id", id: :uuid, default: -> { "newid()" }, force: :cascade do |t|
    t.text "SoftwareName", null: false
    t.text "CurrentVersion", null: false
    t.date "ReleaseDate", null: false
    t.boolean "IsSDX", default: false, null: false
    t.integer "SoftwareType", null: false
    t.boolean "IsDefaultLicense", default: false, null: false
  end

  add_foreign_key "AccountActivity", "AccountHead", column: "AccountHeadId", primary_key: "Id", name: "FK_AccountActivity_AccountHead"
  add_foreign_key "CallDetail", "CallHead", column: "CallHeadId", primary_key: "Id", name: "FK_CallDetail_AccountHead"
  add_foreign_key "CallDetail", "Contact", column: "ContactId", primary_key: "Id", name: "FK_CallDetail_Contact"
  add_foreign_key "CallHead", "AccountHead", column: "AccountHeadId", primary_key: "Id", name: "FK_CallHead_AccountHead"
  add_foreign_key "CallHead", "CallType", column: "CallTypeId", primary_key: "Id", name: "FK_CallHead_CallHead"
  add_foreign_key "CallHead", "ComputerType", column: "ComputerTypeId", primary_key: "Id", name: "FK_CallHead_ComputerType"
  add_foreign_key "CallHead", "Employee", column: "EmployeeId", primary_key: "Id", name: "FK_CallHead_Employee"
  add_foreign_key "ContactAccountRelatedCompanyXlink", "AccountHead", column: "AccountHeadId", primary_key: "Id", name: "FK_ContactAccountRelatedCompanyXlink_AccountHead"
  add_foreign_key "ContactAccountRelatedCompanyXlink", "Contact", column: "ContactId", primary_key: "Id", name: "FK_ContactAccountRelatedCompanyXlink_Contact"
  add_foreign_key "ContactAccountRelatedCompanyXlink", "RelatedCompanyId", column: "RelatedCompanyId", primary_key: "Id", name: "FK_ContactAccountRelatedCompanyXlink_RelatedCompanyId"
  add_foreign_key "License", "AccountHead", column: "AccountHeadId", primary_key: "Id", name: "FK_License_AccountHead"
  add_foreign_key "License", "SoftwareVersion", column: "SoftwareVersionId", primary_key: "Id", name: "FK_License_License"
end
