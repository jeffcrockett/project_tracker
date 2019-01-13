require 'set'

module ApplicationHelper

    def shipments_for_project(x)
        Shipment.where(project_id:x)
    end
    
    def full_project_name(p)
        if p.company_id
            Company.find(p.company_id).name + ': ' + p.name
        end
    end

    def full_shipment_name(s)
        project_name = full_project_name(Project.find(s.project_id))
        product_name = Product.find(s.product_id).name
        date_string = s.date.strftime('%m/%d/%Y')
        project_name + ': ' + product_name + ': ' + date_string
    end

    def company_name_from_full_name(s)
        s.split(': ')[0]
    end

    def project_name_from_full_name(s)
        s.split(': ')[1]
    end

    def company_id_from_full_name(s)
        Company.find_by(name: company_name_from_full_name(s)).id
    end

    def project_id_from_full_name(s)
        Project.find_by(name: project_name_from_full_name(s)).id
    end

    # Given an array of Project records, return the array sorted by 
    # full project name.
    def projects_by_name(projects=Project.all)
        projects.sort_by{|p| full_project_name(p)}
    end

    # Return the full project name of the project to which the given
    # Registration object belongs
    def registration_name(r)
        full_project_name(r.project)
    end

    # Return an unsorted array of all Registration objects associated with
    # the given Company ID.
    def regs_for_company(id)
        Registration.all.find_all{|r| r.project.company_id === id}
    end

    # Given an array of Registration records, return the array sorted by 
    # the full name of the associated Project
    def regs_by_name(regs=Registration.all)
        regs.sort_by{|r| full_project_name(r.project)}
    end

    # Given an array of Registration records, return the array sorted by 
    # expiration date
    def regs_by_expiration(regs=Registration.all)
        regs.sort_by{|r| r.expiration}
    end

    # Projects have a name, but they belong to a Company, and for many
    # purposes the user sees the "full" project name which is the
    # Company name followed by the project name.
    # So that we can populate choice lists with
    # a project ID and the associated project full name, define
    # a ProjName class that contains that information
    class ProjName
        include ApplicationHelper
        def initialize(p)
            @id = p.id 
            @name = full_project_name(p)
        end

        def id 
            @id
        end

        def name 
            @name 
        end


    end

    # Return a list of ProjName objects for all projects, sorted by full name.
    def project_list
        Project.all.map{|p| ProjName.new(p)}.sort_by{|p| p.name}
    end

    # Return a list of ProjName objects for all projects that do not have
    # an associated Registration, sorted by full name.
    def unregistered_project_list
        reg_ids = Set.new(Registration.all.map{|r| r.id})
        Project.all.map{|p| ProjName.new(p)}.reject{|p| reg_ids.include?(p.id)}.sort_by{|p| p.name}
    end


    # Registrations don't have their own name because they belong to a project,
    # which in turn belongs to a company.  There can be at most one 
    # registration per project, so that project's full name also identifies
    # the registration.  So that we can populate choice lists with
    # a registration ID and the associated project full name, define
    # a RegName class that contains that information
    class RegName
        include ApplicationHelper
        def initialize(r)
            @id = r.id 
            @name = full_project_name(r.project)
        end

        def id 
            @id
        end

        def name 
            @name 
        end
    end

    # Return an array of RegName objects for all registrations, sorted by name
    def registration_list
        Registration.all.map{|r| RegName.new(r)}.sort_by{|r| r.name}
    end

    class ShipName 
        include ApplicationHelper
        def initialize(s)
            @id = s.id 
            @name = full_shipment_name(s)
        end
        
        def id 
            @id
        end

        def name 
            @name 
        end
    end


    # Return an array of shipName objects for all shipments, sorted by name
    def shipment_list
        Shipment.all.map{|s| ShipName.new(s)}.sort_by{|s| s.name}
    end

end
