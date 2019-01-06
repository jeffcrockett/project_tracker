module ApplicationHelper
    def full_project_name(p)
        if p.company_id
            Company.find(p.company_id).name + ': ' + p.name
        end
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
end
