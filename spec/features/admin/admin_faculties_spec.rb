# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin::Faculty', type: :feature do
  # vars for existing
  let(:college) { FactoryBot.create(:college) }
  let(:department) { FactoryBot.create(:department) }
  let(:faculty_existing) { FactoryBot.create(:faculty) }
  # vars for creating 
  let(:address) { FactoryBot.attributes_for(:address) }
  let(:phone) { FactoryBot.attributes_for(:phone) }  
  let(:faculty) { FactoryBot.attributes_for(:faculty) }

  before(:each) do
    college
    department
    faculty_existing
  end

  scenario 'testing the index page for faculties and returning proper information' do
    visit '/admin/faculties'
    expect(page).to have_content('Manage Faculty')
  end

  scenario 'creates a new faculty' do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: faculty[:wvu_username]
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content(I18n.t('faculty.success'))
  end

  scenario 'fails creating a new faculty because of no wvu username' do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: ''
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_button 'Submit'
    expect(page).to have_content('Wvu username can\'t be blank')
    expect(page).to have_content('Wvu username is too short (minimum is 4 characters)')
  end

  scenario 'updates an existing faculty' do
    visit "/admin/faculties/#{faculty_existing.id}/edit"
    fill_in 'First name', with: 'Gimli'
    click_button 'Submit'
    expect(page).to have_content(I18n.t('faculty.edited'))
  end

  scenario 'fails updating an existing faculty' do
    visit "/admin/faculties/#{faculty_existing.id}/edit"
    fill_in 'First name', with: 'G'
    click_button 'Submit'
    expect(page).to have_content('First name is too short (minimum is 2 characters)')
  end

  scenario 'deletes an existing faculty' do
    # then visit destroy path
    visit '/admin/faculties'
    click_link 'Delete'
    expect(page).to have_content('Manage Faculty')
    expect(page).to have_content(I18n.t('faculty.deleted'))
    expect(page).to_not have_content(faculty_existing.first_name)
  end

  scenario 'import faculty from csv' do
    visit '/admin/faculties/importcsv'
    expect(page).to have_content('Import CSV File(s)')
    attach_file('csv_files', './spec/support/files/PCI.csv')
    click_button 'Import CSV File(s)'
    expect(page).to have_content(I18n.t('faculty.csv_import_queued'))
  end

  scenario 'import faculty from csv' do
    file_path = 'tmp/file.txt'
    FileUtils.touch(file_path)

    visit '/admin/faculties/importcsv'
    expect(page).to have_content('Import CSV File(s)')
    attach_file('csv_files', file_path)
    click_button 'Import CSV File(s)'
    expect(page).to have_content('You are not allowed to upload')
  end

  scenario 'import faculty from zip' do
    visit '/admin/faculties/importzip'
    expect(page).to have_content('Import Digital Measures Zip')
    attach_file('zip_file', './spec/support/files/PCI.zip')
    click_button 'Import ZIP File'
    expect(page).to have_content(I18n.t('faculty.zip_import_queued'))
  end

  scenario 'try to import a txt file in the zip file page' do
    file_path = 'tmp/file.txt'
    FileUtils.touch(file_path)

    visit '/admin/faculties/importzip'
    expect(page).to have_content('Import Digital Measures Zip')
    attach_file('zip_file', file_path)
    click_button 'Import ZIP File'
    expect(page).to have_content('You are not allowed to upload')
  end

  scenario 'accepts nested attributes for address', js: true do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: faculty[:wvu_username]
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_link 'Add Address'
    fill_in 'Street Address', with: address[:line_1]
    fill_in 'City', with: address[:city]
    select('OH', from: 'State')
    fill_in 'Zip', with: address[:zip]
    click_button 'Submit'
    expect(page).to have_content(I18n.t('faculty.success'))
  end

  scenario 'accepts nested attributes for phones', js: true do
    visit '/admin/faculties/new'
    select('Mr', from: 'Prefix')
    fill_in 'First name', with: faculty[:first_name]
    fill_in 'Middle name', with: faculty[:middle_name]
    fill_in 'Last name', with: faculty[:last_name]
    select('I', from: 'Suffix')
    fill_in 'Wvu username', with: faculty[:wvu_username]
    fill_in 'Email', with: faculty[:email]
    fill_in 'Title', with: faculty[:title]
    fill_in 'Biography', with: faculty[:biography]
    fill_in 'Research interests', with: faculty[:research_interests]
    select('user', from: 'User Role')
    select('enabled', from: 'User Status')
    click_link 'Add Phones'
    select('phone', from: 'Number types')
    fill_in 'Number', with: phone[:number]
    click_button 'Submit'
    expect(page).to have_content(I18n.t('faculty.success'))
  end
end
