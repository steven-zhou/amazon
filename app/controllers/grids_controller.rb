class GridsController < ApplicationController
  # Nothing needed here for System Logs

  
  def people_search_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @people = PeopleSearchGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @people.size
    end

    # User provided search terms
    if(query != "%%")
      @people = PeopleSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @people.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @people.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def feedback_search_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "desc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @feedback = FeedbackSearchGrid.find(:all,
        :conditions => [],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @feedback.size
    end

    # User provided search terms
    if(query != "%%")
      @feedback = FeedbackSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query])
      count = @feedback.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @feedback.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def system_log_search_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "created_at"
    end

    if (!sortorder)
      sortorder = "DESC"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @system_log_entries = SystemLogSearchGrid.find(:all,
        :conditions => [],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @system_log_entries.size
    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLogSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query ])
      count = @system_log_entries.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @system_log_entries.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6
        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def system_log_archive_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "created_at"
    end

    if (!sortorder)
      sortorder = "DESC"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @system_log_entries = SystemLogArchiveGrid.find(:all,
        :conditions => [],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @system_log_entries.size
    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLogArchiveGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query ])
      count = @system_log_entries.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @system_log_entries.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6
        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def organisation_search_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisation = OrganisationSearchGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @organisation.size
    end

    # User provided search terms
    if(query != "%%")
      @organisation = OrganisationSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @organisation.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @organisation.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end
  
  def query_result_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @entity = QueryResultGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @entity.size
    end

    # User provided search terms
    if(query != "%%")
      @entity = QueryResultGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @entity.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @entity.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6,
          u.field_7,
          u.field_8,
          u.field_9,
          u.field_10]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def list_edit_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @list_details = ListDetail.find(:all,
        :conditions => ["list_header_id = ?", params[:id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["person", "organisation"]
      )
      count = @list_details.size
    end

    # User provided search terms
    if(query != "%%")
      @list_details = ListDetail.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["person", "organisation"],
        :conditions=>[qtype +" ilike ? AND list_header_id = ?", query, params[:id]])
      count = @list_details.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    if (params[:entity] == "person")
      return_data[:rows] = @list_details.collect{|u| {:id => u.id,
          :cell=>[u.id,
            u.person.first_name,
            u.person.family_name]}}
    else
      return_data[:rows] = @list_details.collect{|u| {:id => u.id,
          :cell=>[u.id,
            u.organisation.full_name,
            u.organisation.trading_as]}}
    end
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def list_compile_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @people = ListCompileGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @people.size
    end

    # User provided search terms
    if(query != "%%")
      @people = ListCompileGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @people.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @people.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_other_group_organisations_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisations = ShowOtherGroupOrganisationsGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )

      count = @organisations.size

    end

    # User provided search terms
    if(query != "%%")

      @organisations = ShowOtherGroupOrganisationsGrid.find(:all,

        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])

      count = @organisations.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @organisations.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def organisation_employee_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end


    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisation_employee = OrganisationEmployeeGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @organisation_employee.size
    end

    # User provided search terms
    if(query != "%%")
      @organisation_employee  = OrganisationEmployeeGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @organisation_employee.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @organisation_employee.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_other_member_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @other_group_member = ShowOtherGroupMemberGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @other_group_member.size
    end

    # User provided search terms
    if(query != "%%")
      @other_group_member  = ShowOtherGroupMemberGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @other_group_member.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @other_group_member.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

 
  def personal_check_duplication
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @personal_check_duplication = DuplicationPersonalGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )

      count = @personal_check_duplication.size
    end

    # User provided search terms
    if(query != "%%")
      @personal_check_duplication  = DuplicationPersonalGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])

      count = @personal_check_duplication.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @personal_check_duplication.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def duplication_organisations_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisations = DuplicationOrganisationsGrid.find(:all,

        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @organisations.size
    end

    # User provided search terms
    if(query != "%%")
      @organisations  = DuplicationOrganisationsGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
    	count = @organisations.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @organisations.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_person_contacts_report_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @person_contact_report = PersonContactsReportGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @person_contact_report.size
    end

    # User provided search terms
    if(query != "%%")
      @person_contact_report = PersonContactsReportGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @person_contact_report.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @person_contact_report.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_organisation_contacts_report_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisation_contact_report = OgansisationContactsReportGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @organisation_contact_report.size
    end

    # User provided search terms
    if(query != "%%")

      @organisation_contact_report = OgansisationContactsReportGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @organisation_contact_report.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @organisation_contact_report.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5,
          u.field_6]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_postcode_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"
    suburb = "%"+params[:suburb]+"%"
    postcode = "%"+params[:postcode]+"%"
    state = "%"+params[:state]+"%"

    # No search terms provided

    if(query == "%%")
      @show_postcode = Postcode.find(:all,
        :conditions => ["suburb ilike ? AND postcode ilike ? AND state ilike ?", suburb, postcode, state],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["country"]
      )
      count = @show_postcode.size
    end

    # User provided search terms
    if(query != "%%")
      @show_postcode = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND suburb ilike ? AND postcode ilike ? AND state ilike ?", query, suburb, postcode, state],
        :include => ["country"])
      count = @show_postcode.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @show_postcode.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.state,
          u.suburb,
          u.postcode,                
          u.country_id.nil? ? "" : u.country.short_name
        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end
   
  def show_list_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @people = ShowListGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @people.size
    end

    # User provided search terms
    if(query != "%%")

      @people = ShowListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @people.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @people.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_organisation_list_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @organisation = ShowOrganisationListGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @organisation.size
    end

    # User provided search terms
    if(query != "%%")
      @organisation = ShowOrganisationListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @organisation.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @organisation.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_person_lookup_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @person_lookup = PersonLookupGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @person_lookup.size
    end

    # User provided search terms
    if(query != "%%")
      @person_lookup = PersonLookupGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = @person_lookup.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @person_lookup.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_countries_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @country = Country.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["main_language"]
      )
      count = @country.size
    end

    # User provided search terms
    if(query != "%%")
      @country = Country.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["main_language"])
      count = @country.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @country.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.long_name,
          u.short_name,
          u.citizenship,
          u.capital,
          u.iso_code,
          u.dialup_code,
          u.main_language_id.nil? ? "" : u.main_language.name,
          #         u.govenment_language,
          u.currency,
          u.currency_subunit]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_campaigns_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "start_date, name"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @campaign = Campaign.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start

      )
      count = @campaign.size
    end

    # User provided search terms
    if(query != "%%")
      @campaign = Campaign.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query])
      count = @campaign.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @campaign.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+ "</span>": u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>": u.name,
          u.to_be_removed? ? "<span class='red'>"+u.description+"</span>": u.description,
          u.to_be_removed? ? "<span class='red'>"+u.target_amount+"</span>" : u.target_amount,
          u.start_date.nil?  ? '' : (u.to_be_removed? ? "<span class='red'>"+u.start_date.strftime('%d-%m-%Y')+"</span>" : u.start_date.strftime('%d-%m-%Y')),
          u.end_date.nil? ? '' : ( u.to_be_removed? ?  "<span class='red'>"+u.end_date.strftime('%d-%m-%Y')+"</span>" : u.end_date.strftime('%d-%m-%Y')),
          (u.status? ? (u.to_be_removed? ? "<span class='red'>Active</span>" : 'Active') : (u.to_be_removed? ? "<span class='red'>Inactive</span>":'Inactive')),
          u.to_be_removed? ? "<span class='red'>"+u.remarks+"</span>" : u.remarks
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_languages_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @language = Language.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @language.size
    end

    # User provided search terms
    if(query != "%%")
      @language = Language.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @language.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @language.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_geographicalarea_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @geographical_area = GeographicalArea.find(:all,
        :conditions => ["country_id=?", params[:country_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @geographical_area.size
    end

    # User provided search terms
    if(query != "%%")
      @geographical_area = GeographicalArea.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
      count = @geographical_area.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @geographical_area.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.division_name,
          u.remarks]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_religions_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @religion = Religion.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @religion.size
    end

    # User provided search terms
    if(query != "%%")
      @religion = Religion.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @religion.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @religion.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_electoral_area_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @electoral_area = ElectoralArea.find(:all,
        :conditions => ["country_id=?", params[:country_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @electoral_area.size
    end

    # User provided search terms
    if(query != "%%")
      @electoral_area = ElectoralArea.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
      count = @electoral_area.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @electoral_area.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.division_name,
          u.remarks]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_postcodes_by_country_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    relatedb = []   #the post_area table use sti, so need to specify which table to be include when doing search
    if params[:qtype].include?("Geo Area")
 
      params[:qtype] = "post_areas.type = 'GeographicalArea' AND post_areas.division_name"

      relatedb = ["geographical_area"]
    end

    if params[:qtype].include?("Electoral Area")

      params[:qtype] = "post_areas.type = 'ElectoralArea' AND post_areas.division_name"
      relatedb = ["electoral_area"]

    end

    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @postcodes = Postcode.find(:all,
        :conditions => ["postcodes.country_id = ?", session[:postcode_country_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["geographical_area","electoral_area"]
      )
      count = @postcodes.size
    end

    # User provided search terms
    if(query != "%%")
      @postcodes = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND postcodes.country_id = ?", query, session[:postcode_country_id]],
        :include => relatedb)
      count = @postcodes.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @postcodes.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.state,
          u.suburb,
          u.postcode,
          u.geographical_area_id.nil? ? "" : u.geographical_area.division_name,
          u.electoral_area_id.nil? ? "" : u.electoral_area.division_name
        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_sources_by_campaign_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @sources = Source.find(:all,
        :conditions => ["campaign_id = ? ", session[:source_campaign_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @sources.size
    end

    # User provided search terms
    if(query != "%%")
      @sources = Source.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND campaign_id = ?", query, session[:source_campaign_id]])
      count = @sources.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @sources.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+ "</span>": u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>": u.name,
          u.to_be_removed? ? "<span class='red'>"+u.description+"</span>" : u.description,
          u.to_be_removed? ? "<span class='red'>"+u.volume.to_s+"</span>" : u.volume,
          u.to_be_removed? ? "<span class='red'>"+u.cost.to_s+"</span>" : u.cost,
          (u.status? ? (u.to_be_removed? ? "<span class='red'>Active</span>" : 'Active') : (u.to_be_removed? ? "<span class='red'>Inactive</span>":'Inactive'))
        ]}}

    # Convert the hash to a json object
    render :text => return_data.to_json, :layout => false
  end

  def show_receipt_accounts_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @receipt_accounts = ReceiptAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["link_module"]
      )
      count = @receipt_accounts.size
    end

    # User provided search terms
    if(query != "%%")
      @receipt_accounts = ReceiptAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["link_module"])
      count = @receipt_accounts.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @receipt_accounts.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+"</span>" : u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed? ? "<span class='red'>"+u.description+"</span>" : u.description,
          u.link_module.nil? ? "" : ((u.link_module.to_be_removed? || u.to_be_removed?) ? "<span class='red'>"+u.link_module.name+"</span>" : u.link_module.name),
          u.to_be_removed? ? "<span class='red'>"+u.post_to_history.to_s+"</span>" : u.post_to_history,
          u.to_be_removed? ? "<span class='red'>"+u.post_to_campaign.to_s+"</span>" : u.post_to_campaign,
          u.to_be_removed? ? "<span class='red'>"+u.send_receipt.to_s+"</span>" : u.send_receipt,
          u.to_be_removed? ? "<span class='red'>"+(u.status? ? 'Active' : 'Inactive')+"</span>" : (u.status? ? 'Active' : 'Inactive')]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_receipt_methods_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @receipt_methods = ReceiptMethod.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @receipt_methods.size
    end

    # User provided search terms
    if(query != "%%")
      @receipt_methods = ReceiptMethod.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @receipt_methods.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @receipt_methods.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.receipt_method_type.name,
          u.description,
          (u.status? ? 'Active' : 'Inactive')
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_client_bank_accounts_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @client_bank_accounts = ClientBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["account_purpose", "bank"]
      )
      count = @client_bank_accounts.size
    end

    # User provided search terms
    if(query != "%%")
      @client_bank_accounts = ClientBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["account_purpose", "bank"])
      count = @client_bank_accounts.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @client_bank_accounts.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+ "</span>": u.id,
          u.bank_id.nil? ? "" : (u.to_be_removed? ? "<span class='red'>"+u.bank.display_name+ "</span>" :  u.bank.display_name),
          u.to_be_removed? ? "<span class='red'>"+u.account_number+ "</span>" :u.account_number,
          u.account_purpose_id.nil? ? "" : (AccountPurpose.find(u.account_purpose_id).to_be_removed? || u.to_be_removed?  ? "<span class='red'>"+u.account_purpose.name+ "</span>" : u.account_purpose.name),
          (u.status? ? (u.to_be_removed? ? "<span class='red'>Active</span>" : 'Active') : (u.to_be_removed? ? "<span class='red'>Inactive</span>":'Inactive'))
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_person_bank_accounts_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @person_bank_accounts = PersonBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @person_bank_accounts.size
    end

    # User provided search terms
    if(query != "%%")
      @person_bank_accounts = PersonBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @person_bank_accounts.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @person_bank_accounts.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.person.name,
          u.bank.display_name,
          u.account_type.name,
          (u.status? ? 'Active' : 'Inactive')
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_allocation_types_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @allocation_types = AllocationType.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @allocation_types.size
    end

    # User provided search terms
    if(query != "%%")
      @allocation_types = AllocationType.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @allocation_types.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @allocation_types.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.link_module_name,
          u.description,
          u.post_to_history,
          u.post_to_campaign,
          u.send_receipt,
          (u.status? ? 'Active' : 'Inactive'),
          u.remarks]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_bank_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @show_bank = Bank.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @show_bank.size
    end

    # User provided search terms
    if(query != "%%")
      @show_bank = Bank.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @show_bank.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @show_bank.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.full_name,
          u.short_name,
          u.branch_name,
          u.branch_number]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_unbanked_transaction_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "transaction_headers.id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @transaction = TransactionHeader.find(:all,
        :conditions => ["transaction_headers.entity_id=? and entity_type=? and banked=?", params[:entity_id], params[:entity_type], false],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"]
      )
      count = @transaction.size
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and entity_type=? and banked=?", query, params[:entity_id], params[:entity_type], false],
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
      count = @transaction.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_number,
          u.transaction_date.to_s,
          u.bank_account.nil? ? "" :(u.bank_account.to_be_removed? ? "<span class = 'red'>"+u.bank_account.account_number+ "</span>" : u.bank_account.account_number),
          u.receipt_meta_type_id.nil? ? "" : u.receipt_meta_meta_type.name,
          u.receipt_type_id.nil? ? "" : u.receipt_meta_type.name,
          u.notes,
          u.total_amount.nil? ? "$0.00" : currencify(u.total_amount)]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def show_transaction_histroy_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @transaction = TransactionHeader.find(:all,
        :conditions => ["transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"]
      )
      count = @transaction.size
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", query, params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
      count = @transaction.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_number,
          u.transaction_date.to_s,
          u.bank_account_id.nil? ? "" :(u.bank_account.to_be_removed? ? "<span class = 'red'>"+u.bank_account.account_number+ "</span>" : u.bank_account.account_number),
          u.receipt_meta_type_id.nil? ? "" : u.receipt_meta_meta_type.name,
          u.receipt_type_id.nil? ? "" : u.receipt_meta_type.name,
          u.notes,
          u.total_amount.nil? ? "$0.00" : currencify(u.total_amount)
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  def temp_transaction_allocation_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @temp_transaction_allocation_grid = TempTransactionAllocationGrid.find(:all,
        :conditions => ["login_account_id=?", @current_user],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @temp_transaction_allocation_grid.size
    end

    # User provided search terms
    if(query != "%%")
      @temp_transaction_allocation_grid = TempTransactionAllocationGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id=?", query, @current_user])
      count = @temp_transaction_allocation_grid.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @temp_transaction_allocation_grid.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.field_1.blank? ? "" : ReceiptAccount.find(u.field_1.to_i).name,
          u.field_2.blank? ? "" : Campaign.find(u.field_2.to_i).name,
          u.field_3.blank? ? "" : Source.find(u.field_3.to_i).name,
          u.field_4,
          u.field_5.blank? ? "$0.00" : currencify(u.field_5),
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end

  def show_existing_transaction_allocations_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @transaction_allocations = TransactionAllocation.find(:all,
        :conditions => ["transaction_header_id=?", params[:transaction_header_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["campaign", "receipt_account", "source"]
      )
      count = @transaction_allocations.size
    end

    # User provided search terms
    if(query != "%%")
      @transaction_allocations = TransactionAllocation.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_header_id=?", query, params[:transaction_header_id]],
        :include => ["campaign", "receipt_account", "source"])
      count = @transaction_allocations.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction_allocations.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_account_id.nil? ? "" : u.receipt_account.name,
          u.campaign_id.nil? ? "" : (u.campaign.to_be_removed? ? "<span class = 'red'>"+u.campaign.name+"</span>" : u.campaign.name),
          u.source_id.nil? ? "" : (u.source.to_be_removed? ? "<span class = 'red'>"+u.source.name+"</span>" :u.source.name),
          u.letter_id.nil? ? "" : u.letter_id,
          u.amount.nil? ? "$0.00" : currencify(u.amount)
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end

  def show_transaction_enquiry_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"
    conditions = Array.new
    values = Array.new

    if params[:entity_type]

      conditions << "transaction_headers.entity_type = ?"
      values << params[:entity_type]
    end


    if params[:entity_id]!="0"

      conditions << "transaction_headers.entity_id = ?"
      values << params[:entity_id]
    end


    if params[:start_id]
      conditions << "transaction_headers.id Between ? And ?"
      values << params[:start_id]
      values << params[:end_id]
    end

    if params[:start_receipt_id]
      conditions << "transaction_headers.receipt_number Between ? And ?"
      values << params[:start_receipt_id]
      values << params[:end_receipt_id]
    end

    if params[:start_system_date]
      conditions << "transaction_headers.todays_date Between ? And ?"
      values << params[:start_system_date].to_date
      values << params[:end_system_date].to_date
    end

    if params[:start_transaction_date]
      conditions << "transaction_headers.transaction_date Between ? And ?"
      values << params[:start_transaction_date].to_date
      values << params[:end_transaction_date].to_date
    end

    if params[:bank_account_id]
      conditions << "transaction_headers.bank_account_id =?"     
      values << params[:bank_account_id].to_i
    end

    if params[:banked]
      conditions << "transaction_headers.banked =?"
      values << params[:banked]
    end

    if params[:receipt_meta_type_id]
      conditions << "transaction_headers.receipt_meta_type_id =?"
      values << params[:receipt_meta_type_id]
    end

    if params[:receipt_type_id]
      conditions << "transaction_headers.receipt_type_id =?"
      values << params[:receipt_type_id]
    end

    if params[:received_via_id]
      conditions << "transaction_headers.received_via_id =?"
      values << params[:received_via_id]
    end

    if params[:receipt_account_id]
      conditions << "transaction_allocations.receipt_account_id =?"
      values << params[:receipt_account_id]
    end

    # No search terms provided
    if(query == "%%")
      @transaction = TransactionHeader.find(:all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type","transaction_allocations"]
      )
      count = @transaction.size
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
      count = @transaction.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_number,
          u.todays_date.to_s,
          u.transaction_date.to_s,
          u.bank_account.nil? ? "" : u.bank_account.account_number,
          u.receipt_meta_type_id.nil? ? "" : u.receipt_meta_meta_type.name,
          u.receipt_type_id.nil? ? "" : u.receipt_meta_type.name,
          u.notes,
          u.total_amount.nil? ? "$0.00" : currencify(u.total_amount)
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

  

  def show_message_templates_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @message_templates = MessageTemplate.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @message_templates.size
    end

    # User provided search terms
    if(query != "%%")
      @message_templates = MessageTemplate.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = @message_templates.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @message_templates.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+"</span>" : u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed? ? "<span class='red'>"+u.created_at.strftime('%d-%m-%Y')+"</span>" : u.created_at.strftime('%d-%m-%Y'),
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def email_maintenance_search_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)

      rp = 20

    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      query_string = params[:dispatch_date]== "false" ? "dispatch_date IS NULL " : "dispatch_date IS NOT NULL"    
      @email_maintenance = BulkEmail.find(:all,
        :conditions => ["created_at >= ? and created_at <= ? and to_be_removed = ? AND status = ? AND #{query_string}", params[:start_date].to_date, params[:end_date].to_date+1, params[:to_be_removed], params[:status]],
        #:conditions => ["created_at >= ? and created_at <= ?", params[:start_date].to_date, params[:end_date].to_date],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )      
      count = @email_maintenance.size     
    end

    # User provided search terms
    if(query != "%%")
      query_string = params[:dispatch_date]== "false" ? "dispatch_date IS NULL " : "dispatch_date IS NOT NULL"
      @email_maintenance = BulkEmail.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND created_at >= ? and created_at <= ? and to_be_removed = ? AND status = ? AND #{query_string}", query, params[:start_date].to_date, params[:end_date].to_date+1, params[:to_be_removed], params[:status]])
      count = @email_maintenance.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @email_maintenance.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to,
          u.subject,
          u.created_at.strftime('%d-%m-%Y %H:%M:%S'),
          u.dispatch_date.nil? ? "Not Dispatched" : "#{u.dispatch_date.strftime('%d-%m-%Y %H:%M:%S')}",
          u.to_be_removed,
          u.status? ? "Active" : "Inactive"

        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def show_notes_grid
    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if(params[:type]!="Person")
      params[:type]="Organisation"
    end

    if (!sortname)
      sortname = "id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 20
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @notes = Note.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>["noteable_id = ? and noteable_type= ?", params[:entity_id],params[:type]]
      )
      count = @notes.size
    end

    # User provided search terms
    if(query != "%%")
      @notes = Note.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? and noteable_id = ? and noteable_type= ?", query,params[:entity_id],params[:type]])
      count = @notes.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @notes.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.label,
          u.short_description,
          u.body_text,
          u.active]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def general_show_all_objects

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    if (!sortname)
      sortname = "grid_object_id"
    end

    if (!sortorder)
      sortorder = "asc"
    end

    if (!page)
      page = 1
    end

    if (!rp)
      rp = 10
    end

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @people = ShowListGrid.find(:all,
        :conditions => ["login_account_id = ? and field_6 = ?", session[:user], true],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = @people.size
    end

    # User provided search terms
    if(query != "%%")

      @people = ShowListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ? and field_6 = ?", query, session[:user], true])
      count = @people.size
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @people.collect{|u| {:id => u.grid_object_id,
        :cell=>[u.grid_object_id,
          u.field_1,
          u.field_2,
          u.field_3,
          u.field_4,
          u.field_5]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

end


