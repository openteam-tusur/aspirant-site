require 'rails_helper'

describe ContactsHelper do
  describe 'string concat' do
    it 'merge subdivision contacts with equal building address and working hours' do
      contacts = Hashie::Mash.new({ subdivision_contacts: [
        {
          additional_contacts: [],
          building: {
            address: 'пр-т Ленина, 40',
            full_address: '634050, Томская область, Томск, пр-т Ленина, 40',
            latitude: '56.4740923862909',
            longtitude: '84.9497518332073',
            title: 'Главный корпус',
            abbr: 'гк',
            downcased_title: 'главный корпус',
            locality: 'Томск'
          },
          office: '235',
          working_hours: 'пн-пт с 8.30 до 17.30, обед с 13.00 до 14.00; сб,вс - выходной',
          emails: [],
          phones: [
            {
              code: '3822',
              number: '701557',
              kind: 'municipal',
              kind_text: 'городской'
            },
            {
              code: nil,
              number: '1139',
              kind: 'internal',
              kind_text: 'внутренний'
            }
          ]
        },
        {
          additional_contacts: [],
          building: {
            address: 'пр-т Ленина, 40',
            full_address: '634050, Томская область, Томск, пр-т Ленина, 40',
            latitude: '56.4740923862909',
            longtitude: '84.9497518332073',
            title: 'Главный корпус',
            abbr: 'гк',
            downcased_title: 'главный корпус',
            locality: 'Томск'
          },
          office: '239',
          working_hours: 'пн-пт с 8.30 до 17.30, обед с 13.00 до 14.00; сб,вс - выходной',
          emails: [],
          phones: [
            {
              code: nil,
              number: '1113',
              kind: 'internal',
              kind_text: 'внутренний'
            }
          ]
        }
      ]
      })

      merged_contacts = Hashie::Mash.new({ subdivision_contacts: [
        additional_contacts: [],
        building: {
          address: 'пр-т Ленина, 40',
          full_address: '634050, Томская область, Томск, пр-т Ленина, 40',
          latitude: '56.4740923862909',
          longtitude: '84.9497518332073',
          title: 'Главный корпус',
          abbr: 'гк',
          downcased_title: 'главный корпус',
          locality: 'Томск'
        },
        office: ['235', '239'],
        working_hours: 'пн-пт с 8.30 до 17.30, обед с 13.00 до 14.00; сб,вс - выходной',
        emails: [],
        phones: [
          {
            code: '3822',
            number: '701557',
            kind: 'municipal',
            kind_text: 'городской'
          },
          {
            code: nil,
            number: '1139',
            kind: 'internal',
            kind_text: 'внутренний'
          },
          {
            code: nil,
            number: '1113',
            kind: 'internal',
            kind_text: 'внутренний'
          }
        ]
      ]
      })

      expect(helper.merge_subdivision_contacts(contacts)).to eq(merged_contacts)
    end

    it 'merge subdivision contacts with equal building address and not equal working hours' do
      contacts = Hashie::Mash.new({ subdivision_contacts: [
        {
          additional_contacts: [],
          building: {
            address: 'пр-т Ленина, 40',
            full_address: '634050, Томская область, Томск, пр-т Ленина, 40',
            latitude: '56.4740923862909',
            longtitude: '84.9497518332073',
            title: 'Главный корпус',
            abbr: 'гк',
            downcased_title: 'главный корпус',
            locality: 'Томск'
          },
          office: '235',
          working_hours: 'пн-пт с 8.30 до 17.30, обед с 13.00 до 14.00; сб,вс - выходной',
          emails: [],
          phones: [
            {
              code: '3822',
              number: '701557',
              kind: 'municipal',
              kind_text: 'городской'
            },
            {
              code: nil,
              number: '1139',
              kind: 'internal',
              kind_text: 'внутренний'
            }
          ]
        },
        {
          additional_contacts: [],
          building: {
            address: 'пр-т Ленина, 40',
            full_address: '634050, Томская область, Томск, пр-т Ленина, 40',
            latitude: '56.4740923862909',
            longtitude: '84.9497518332073',
            title: 'Главный корпус',
            abbr: 'гк',
            downcased_title: 'главный корпус',
            locality: 'Томск'
          },
          office: '239',
          working_hours: 'пн-пт с 9.00 до 18.00, обед с 13.00 до 14.00; сб,вс - выходной',
          emails: [],
          phones: [
            {
              code: nil,
              number: '1113',
              kind: 'internal',
              kind_text: 'внутренний'
            }
          ]
        }
      ]
      })

      merged_contacts = contacts

      expect(helper.merge_subdivision_contacts(contacts)).to eq(merged_contacts)
    end
  end
end
