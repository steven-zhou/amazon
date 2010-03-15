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
      count = PeopleSearchGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @people = PeopleSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = PeopleSearchGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = FeedbackSearchGrid.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @feedback = FeedbackSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query])
      count = FeedbackSearchGrid.count(:all, :conditions=>[qtype +" ilike ? ", query])
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
    conditions = Array.new
    values = Array.new

    if params[:user_name]
      conditions << "login_accounts.user_name ilike ?"
      values << params[:user_name]
    end
    if params[:status]
      conditions << "system_logs.status ilike ?"
      values << params[:status]
    end
    if params[:start_date]
      conditions << "system_logs.created_at >= ?"
      values << params[:start_date].to_date
    end
    if params[:end_date]
      conditions << "system_logs.created_at <= ?"
      values << params[:end_date].to_date.tomorrow
    end

    # No search terms provided
    if(query == "%%")
      @system_log_entries = SystemLog.find(:all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["login_account"]
      )
      count = SystemLog.count(:all, :conditions => [conditions.join(' AND '), *values],:include => ["login_account"])


    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLog.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["login_account"],
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values])
      count = SystemLog.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],:include => ["login_account"])

    end



    

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @system_log_entries.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.created_at.getlocal.strftime('%a %d %b %Y %H:%M:%S'),
          u.login_account.nil? ? "Unknown" : u.login_account.formatted_name,
          u.ip_address,
          u.controller,
          u.action,
          u.message
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
      count = SystemLogArchiveGrid.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLogArchiveGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query ])
      count = SystemLogArchiveGrid.find(:all, :conditions=>[qtype +" ilike ? ", query ])
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
      count = OrganisationSearchGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @organisation = OrganisationSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = OrganisationSearchGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = QueryResultGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @entity = QueryResultGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = QueryResultGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ListDetail.count(:all, :conditions => ["list_header_id = ?", params[:id]], :include => ["person", "organisation"])
    end

    # User provided search terms
    if(query != "%%")
      @list_details = ListDetail.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["person", "organisation"],
        :conditions=>[qtype +" ilike ? AND list_header_id = ?", query, params[:id]])
      count = ListDetail.count(:all, :include => ["person", "organisation"], :conditions=>[qtype +" ilike ? AND list_header_id = ?", query, params[:id]])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    if (params[:entity] == "person")
      return_data[:rows] = @list_details.collect{|u| {:id => u.id,
          :cell=>[u.entity_id,
            u.person.first_name,
            u.person.family_name]}}
    else
      return_data[:rows] = @list_details.collect{|u| {:id => u.id,
          :cell=>[u.entity_id,
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
      count = ListCompileGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @people = ListCompileGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ListCompileGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ShowOtherGroupOrganisationsGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")

      @organisations = ShowOtherGroupOrganisationsGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ShowOtherGroupOrganisationsGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = OrganisationEmployeeGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @organisation_employee  = OrganisationEmployeeGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = OrganisationEmployeeGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ShowOtherGroupMemberGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @other_group_member  = ShowOtherGroupMemberGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ShowOtherGroupMemberGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

      count = DuplicationPersonalGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @personal_check_duplication  = DuplicationPersonalGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])

      count = DuplicationPersonalGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = DuplicationOrganisationsGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @organisations  = DuplicationOrganisationsGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
    	count = DuplicationOrganisationsGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = PersonContactsReportGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @person_contact_report = PersonContactsReportGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = PersonContactsReportGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = OgansisationContactsReportGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")

      @organisation_contact_report = OgansisationContactsReportGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = OgansisationContactsReportGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = Postcode.count(:all, :conditions => ["suburb ilike ? AND postcode ilike ? AND state ilike ?", suburb, postcode, state], :include => ["country"])
    end

    # User provided search terms
    if(query != "%%")
      @show_postcode = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND suburb ilike ? AND postcode ilike ? AND state ilike ?", query, suburb, postcode, state],
        :include => ["country"])
      count = Postcode.count(:all, :conditions=>[qtype +" ilike ? AND suburb ilike ? AND postcode ilike ? AND state ilike ?", query, suburb, postcode, state], :include => ["country"])
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
      count = ShowListGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")

      @people = ShowListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ShowListGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ShowOrganisationListGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @organisation = ShowOrganisationListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ShowOrganisationListGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = PersonLookupGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @person_lookup = PersonLookupGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = PersonLookupGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = Country.count(:all, :include => ["main_language"])
    end

    # User provided search terms
    if(query != "%%")
      @country = Country.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["main_language"])
      count = Country.count(:all, :conditions=>[qtype +" ilike ?", query], :include => ["main_language"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @country.collect{|u| {:id => u.id,
        :cell=>[u.id,
          #          u.long_name,
          #          u.short_name,
          #          u.citizenship,
          #          u.capital,
          #          u.iso_code,
          #          u.iso_number,
          #          u.dialup_code,
          #          u.main_language_id.nil? ? "" : u.main_language.name,
          #          #         u.govenment_language,
          #          u.currency,
          #          u.currency_subunit
          u.to_be_removed? ? "<span class='red'>"+u.long_name+"</span>": u.long_name,
          u.to_be_removed? ? "<span class='red'>"+u.short_name+"</span>": u.short_name,
          u.to_be_removed? ? "<span class='red'>"+u.citizenship+"</span>": u.citizenship,
          u.capital.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.capital+"</span>": u.capital,
          u.iso_code.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.iso_code+"</span>": u.iso_code,
          u.iso_number.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.iso_number+"</span>": u.iso_number,
          u.dialup_code.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.dialup_code+"</span>": u.dialup_code,

          u.main_language_id.nil? ? "" :  u.to_be_removed? ? "<span class='red'>"+u.main_language.name+"</span>": u.main_language.name,
          u.currency.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.currency+"</span>": u.currency,
          u.currency_subunit.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.currency_subunit+"</span>": u.currency_subunit          ]}}
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
      count = Campaign.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @campaign = Campaign.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query])
      count = Campaign.count(:all, :conditions=>[qtype +" ilike ? ", query])
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
      count = Language.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @language = Language.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = Language.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @language.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,

          u.description.nil? ?  "" :  u.to_be_removed? ? "<span class='red'>"+u.description+"</span>" : u.description]}}
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
      count = GeographicalArea.count(:all, :conditions => ["country_id=?", params[:country_id]])
    end

    # User provided search terms
    if(query != "%%")
      @geographical_area = GeographicalArea.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
      count = GeographicalArea.count(:all, :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @geographical_area.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed? ? "<span class='red'>"+u.division_name+"</span>" : u.division_name,
          u.remarks.nil? ? "" : (u.to_be_removed? ? "<span class='red'>"+u.remarks+ "</span>" :  u.remarks)
        ]}}
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
      count = Religion.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @religion = Religion.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = Religion.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @religion.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,

          u.description.nil? ?  "" :  u.to_be_removed? ? "<span class='red'>"+u.description+"</span>" : u.description]}}

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
      count = ElectoralArea.count(:all, :conditions => ["country_id=?", params[:country_id]])
    end

    # User provided search terms
    if(query != "%%")
      @electoral_area = ElectoralArea.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
      count = ElectoralArea.count(:all, :conditions=>[qtype +" ilike ? AND country_id = ?", query, params[:country_id]])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @electoral_area.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed? ? "<span class='red'>"+u.division_name+"</span>" : u.division_name,
          u.remarks.nil? ? "" : (u.to_be_removed? ? "<span class='red'>"+u.remarks+ "</span>" :  u.remarks)
        ]}}
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
      count = Postcode.count(:all, :conditions => ["postcodes.country_id = ?", session[:postcode_country_id]], :include => ["geographical_area","electoral_area"])
    end

    # User provided search terms
    if(query != "%%")
      @postcodes = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND postcodes.country_id = ?", query, session[:postcode_country_id]],
        :include => relatedb)
      count = Postcode.count(:all, :conditions=>[qtype +" ilike ? AND postcodes.country_id = ?", query, session[:postcode_country_id]], :include => relatedb)
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @postcodes.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed? ? "<span class='red'>"+u.state+"</span>": u.state,
          u.to_be_removed? ? "<span class='red'>"+u.suburb+"</span>": u.suburb,
          u.to_be_removed? ? "<span class='red'>"+u.postcode+"</span>": u.postcode,
          u.geographical_area_id.nil? ? "" :(u.to_be_removed? ? "<span class='red'>"+u.geographical_area.division_name+"</span>": u.geographical_area.division_name),
          u.electoral_area_id.nil? ? "" :(u.to_be_removed? ? "<span class='red'>"+u.electoral_area.division_name+"</span>": u.electoral_area.division_name),

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
      count = Source.count(:all, :conditions => ["campaign_id = ? ", session[:source_campaign_id]])
    end

    # User provided search terms
    if(query != "%%")
      @sources = Source.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND campaign_id = ?", query, session[:source_campaign_id]])
      count = Source.count(:all, :conditions=>[qtype +" ilike ? AND campaign_id = ?", query, session[:source_campaign_id]])
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
      count = ReceiptAccount.count(:all, :include => ["link_module"])
    end

    # User provided search terms
    if(query != "%%")
      @receipt_accounts = ReceiptAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["link_module"])
      count = ReceiptAccount.count(:all, :conditions=>[qtype +" ilike ?", query], :include => ["link_module"])
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
      count = ReceiptMethod.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @receipt_methods = ReceiptMethod.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = ReceiptMethod.count(:all, :conditions=>[qtype +" ilike ?", query])
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
      count = ClientBankAccount.count(:all, :include => ["account_purpose", "bank"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @client_bank_accounts = ClientBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["account_purpose", "bank"])
      count = ClientBankAccount.count(:all, :conditions=>[qtype +" ilike ?", query], :include => ["account_purpose", "bank"])
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
      count = PersonBankAccount.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @person_bank_accounts = PersonBankAccount.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = PersonBankAccount.count(:all, :conditions=>[qtype +" ilike ?", query])
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
      count = AllocationType.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @allocation_types = AllocationType.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = AllocationType.count(:all, :conditions=>[qtype +" ilike ?", query])
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
      count = Bank.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @show_bank = Bank.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = Bank.count(:all, :conditions=>[qtype +" ilike ?", query])
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
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"]
      )
      count = TransactionHeader.count(:all, :conditions => ["transaction_headers.entity_id=? and entity_type=? and banked=?", params[:entity_id], params[:entity_type], false],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and entity_type=? and banked=?", query, params[:entity_id], params[:entity_type], false],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
      count = TransactionHeader.count(:all, :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and entity_type=? and banked=?", query, params[:entity_id], params[:entity_type], false],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
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
          u.payment_method_meta_type_id.nil? ? "" : u.payment_method_meta_type.name,
          u.payment_method_type_id.nil? ? "" : u.payment_method_type.name,
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
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"]
      )
      count = TransactionHeader.count(:all, :conditions => ["transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", query, params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
      count = TransactionHeader.count(:all, :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", query, params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
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
          u.payment_method_meta_type_id.nil? ? "" : u.payment_method_meta_type.name,
          u.payment_method_type_id.nil? ? "" : u.payment_method_type.name,
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
      count = TempTransactionAllocationGrid.count(:all, :conditions => ["login_account_id=?", @current_user])
    end

    # User provided search terms
    if(query != "%%")
      @temp_transaction_allocation_grid = TempTransactionAllocationGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id=?", query, @current_user])
      count = TempTransactionAllocationGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id=?", query, @current_user])
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
      count = TransactionAllocation.count(:all, :conditions => ["transaction_header_id=?", params[:transaction_header_id]], :include => ["campaign", "receipt_account", "source"])
    end

    # User provided search terms
    if(query != "%%")
      @transaction_allocations = TransactionAllocation.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_header_id=?", query, params[:transaction_header_id]],
        :include => ["campaign", "receipt_account", "source"])
      count = TransactionAllocation.count(:all, :conditions=>[qtype +" ilike ? AND transaction_header_id=?", query, params[:transaction_header_id]],
        :include => ["campaign", "receipt_account", "source"])
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


    if params[:entity_id]
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

    if params[:payment_method_meta_type_id]
      conditions << "transaction_headers.payment_method_meta_type_id =?"
      values << params[:payment_method_meta_type_id]
    end

    if params[:payment_method_type_id]
      conditions << "transaction_headers.payment_method_type_id =?"
      values << params[:payment_method_type_id]
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
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type","transaction_allocations"]
      )
      count = TransactionHeader.count(:all, :conditions => [conditions.join(' AND '), *values],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type","transaction_allocations"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
      count = TransactionHeader.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :include => ["bank_account", "payment_method_meta_type", "payment_method_type"])
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
          u.payment_method_meta_type_id.nil? ? "" : u.payment_method_meta_type.name,
          u.payment_method_type_id.nil? ? "" : u.payment_method_type.name,
          u.notes,
          u.total_amount.nil? ? currencify(0) : currencify(u.total_amount)
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
      @message_templates = params[:model_type].constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["template_category"]
      )
      count = params[:model_type].constantize.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @message_templates = params[:model_type].constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["template_category"])
      count = params[:model_type].constantize.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @message_templates.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+"</span>" : u.id,
          u.template_category.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.template_category.name+"</span>" : u.template_category.name,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed? ? "<span class='red'>"+u.created_at.getlocal.strftime('%d-%m-%Y')+"</span>" : u.created_at.getlocal.strftime('%d-%m-%Y'),
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


     conditions = Array.new
    values = Array.new


    if params[:start_date]
      conditions << "created_at >= ?"
      values << params[:start_date].to_date
    end


    if params[:end_date]
      conditions << "created_at <= ?"
      values << params[:end_date].to_date+1

    end

    if params[:to_be_removed]
      conditions << "to_be_removed = ?"
      values << params[:to_be_removed]

    end

    if params[:status]
      conditions << "status = ?"
      values << params[:status]

    end

#     if params[:dispatch_date] == "false"
#
#      conditions << "dispatch_date IS"
#      values << "NULL"
#     else
#      conditions << "dispatch_date IS NOT"
#      values << "NULL"
#
#    end



    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      query_string = params[:dispatch_date]== "false" ? "dispatch_date IS NULL " : "dispatch_date IS NOT NULL"
      @email_maintenance = params[:model_type].constantize.find(:all,
       :conditions => [query_string + " AND " + conditions.join(' AND '), *values],

        #:conditions => ["created_at >= ? and created_at <= ?", params[:start_date].to_date, params[:end_date].to_date],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )      
      count = params[:model_type].constantize.count(:all,:conditions => [query_string + " AND " +conditions.join(' AND '), *values] )
    end

    # User provided search terms
    if(query != "%%")
      query_string = params[:dispatch_date]== "false" ? "dispatch_date IS NULL " : "dispatch_date IS NOT NULL"
      @email_maintenance = params[:model_type].constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
       :conditions => [query_string + " AND " +conditions.join(' AND '), *values])
      count = params[:model_type].constantize.count(:all, :conditions => [query_string + " AND " +conditions.join(' AND '), *values])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @email_maintenance.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to,
          u.subject,
          u.created_at.getlocal.strftime('%d-%m-%Y %H:%M:%S'),
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
      count = Note.count(:all, :conditions=>["noteable_id = ? and noteable_type= ?", params[:entity_id],params[:type]]
      )
    end

    # User provided search terms
    if(query != "%%")
      @notes = Note.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? and noteable_id = ? and noteable_type= ?", query,params[:entity_id],params[:type]])
      count = Note.count(:all, :conditions=>[qtype +" ilike ? and noteable_id = ? and noteable_type= ?", query,params[:entity_id],params[:type]])
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
          u.active? ? "Active" : "Inactive"]}}
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
      count = ShowListGrid.count(:all, :conditions => ["login_account_id = ? and field_6 = ?", session[:user], true])
    end

    # User provided search terms
    if(query != "%%")

      @people = ShowListGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ? and field_6 = ?", query, session[:user], true])
      count = ShowListGrid.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id = ? and field_6 = ?", query, session[:user], true])
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



  def show_mail_templates_grid
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
      @mail_templates = params[:model_type].constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["template_category"]
      )
      count = params[:model_type].constantize.count(:all,:include => ["template_category"])
    end

    # User provided search terms
    if(query != "%%")
      @mail_templates = params[:model_type].constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["template_category"])
      count = params[:model_type].constantize.count(:all, :conditions=>[qtype +" ilike ?", query],:include => ["template_category"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @mail_templates.collect{|u| {:id => u.id,
        :cell=>[u.to_be_removed? ? "<span class='red'>"+u.id.to_s+"</span>" : u.id,
          u.template_category.nil? ? "" : u.to_be_removed? ? "<span class='red'>"+u.template_category.name+"</span>" : u.template_category.name,
          u.to_be_removed? ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed? ? "<span class='red'>"+u.created_at.getlocal.strftime('%d-%m-%Y')+"</span>" : u.created_at.getlocal.strftime('%d-%m-%Y'),
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end


  def show_keywords_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    keyword_type_id = params[:keyword_type_id]

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

    #No search terms provided
    if(query == "%%")
      @keywords = Keyword.find(
        :all,
        :conditions => ["keyword_type_id = ?", keyword_type_id],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      )
      count = Keyword.count(:all, :conditions => ["keyword_type_id = ?", keyword_type_id])
    end


    if(query != "%%")
      @keywords = Keyword.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND keyword_type_id = ? ", query, keyword_type_id])
      count = Keyword.count(:all, :conditions=>[qtype +" ilike ? AND keyword_type_id = ? ", query, keyword_type_id])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @keywords.collect{|u| {
        :id => u.id,
        :cell => [
          u.to_be_removed ? "<span class='red'>"+(u.id.nil? ? "" : u.id.to_s)+"</span>" : u.id,
          u.to_be_removed ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed ? "<span class='red'>"+(u.description.nil? ? "" : u.description)+"</span>" : u.description
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_system_data_grid

    page = (params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    amazon_type = params[:type]
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
      @amazon_setting = AmazonSetting.find(:all,
        :conditions => ["type = ? ", amazon_type],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = AmazonSetting.count(:all, :conditions => ["type = ?", amazon_type])
    end
    # User provided search terms
    if(query != "%%")
   
      @amazon_setting = AmazonSetting.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND type = ? ", query, amazon_type])
      count = AmazonSetting.count(:all, :conditions=>[qtype +" ilike ? AND type = ? ", query, amazon_type])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @amazon_setting.collect{|u| {:id => u.id,
        :cell=>[
          u.to_be_removed ? "<span class='red'>"+(u.id.nil? ? "" : u.id.to_s)+"</span>" : u.id,
          u.to_be_removed ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed ? "<span class='red'>"+(u.description.nil? ? "" : u.description)+"</span>" : u.description
        ]}}

    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def show_roles_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    role_type_id = params[:role_type_id]

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

    #No search terms provided
    if(query == "%%")
      @roles = Role.find(
        :all,
        :conditions => ["role_type_id = ?", role_type_id],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      )
      count = Role.count(:all, :conditions => ["role_type_id = ?", role_type_id])
    end

    if(query != "%%")
      @roles = Role.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND role_type_id = ? ", query, role_type_id])
      count = Role.count(:all, :conditions=>[qtype +" ilike ? AND role_type_id = ? ", query, role_type_id])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @roles.collect{|u| {
        :id => u.id,
        :cell => [
          u.to_be_removed ? "<span class='red'>"+(u.id.nil? ? "" : u.id.to_s)+"</span>" : u.id,
          u.to_be_removed ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed ? "<span class='red'>"+(u.remarks.nil? ? "" : u.remarks)+"</span>" : u.remarks
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_group_lists_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    tag_type_id = params[:tag_type_id]
  
    sortname ? sortname : "grid_object_id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    #No search terms provided
    if(query == "%%")
      @group_types = GroupType.find(
        :all,
        :conditions => ["tag_type_id = ?", tag_type_id],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      )
      count = GroupType.count(:all, :conditions => ["tag_type_id = ?", tag_type_id])
    end

    if(query != "%%")
      @group_types = GroupType.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND tag_type_id = ? ", query, tag_type_id])
      count = GroupType.count(:all, :conditions=>[qtype +" ilike ? AND tag_type_id = ? ", query, tag_type_id])
    end
    
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @group_types.collect{|u| {
        :id => u.id,
        :cell => [
          u.to_be_removed ? "<span class='red'>"+(u.id.nil? ? "" : u.id.to_s)+"</span>" : u.id,
          u.to_be_removed ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed ? "<span class='red'>"+(u.description.nil? ? "" : u.description)+"</span>" : u.description
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_user_accounts_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    
    sortname ? sortname : "grid_object_id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    #No search terms provided
    if(query == "%%")
      @login_accounts = SystemUser.find(
        :all,
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      ) rescue @login_accounts = SystemUser.new
      count = SystemUser.count(:all)
    end

    if(query != "%%")
      @login_accounts = SystemUser.find(
        :all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query]) rescue @login_accounts = SystemUser.new
      count = SystemUser.count(:all, :conditions=>[qtype +" ilike ? ", query])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @login_accounts.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.person_id.nil? ? "" : u.person_id,
          u.user_name.nil? ? "" : u.user_name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_user_groups_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    tag_type_id = params[:tag_type_id]

    sortname ? sortname : "grid_object_id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    #No search terms provided
    if(query == "%%")
      @group_types = GroupType.find(
        :all,
        :conditions=>["tag_type_id = ?", tag_type_id],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      ) rescue @group_types = GroupType.new
      count = GroupType.count(:all, :conditions=>["tag_type_id = ?", tag_type_id])
    end

    if(query != "%%")
      @group_types = GroupType.find(
        :all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?  AND tag_type_id = ?", query, tag_type_id]) rescue @group_types = GroupType.new
      count = GroupType.count(:all, :conditions=>[qtype +" ilike ?  AND tag_type_id = ?", query, tag_type_id])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @group_types.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.name.nil? ? "" : u.name,
          u.login_accounts.size.nil? ? "" : u.login_accounts.size
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_user_list_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
    
    sortname ? sortname : "grid_object_id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    #No search terms provided
    if(query == "%%")
      @systemusers = SystemUser.find(
        :all,
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start
      ) rescue @systemusers = SystemUser.new
      count = SystemUser.count(:all)
    end

    if(query != "%%")
      @systemusers = SystemUser.find(
        :all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query]) rescue @systemusers = SystemUser.new
      count = SystemUser.count(:all, :conditions=>[qtype +" ilike ? ", query])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @systemusers.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.user_name.nil? ? "" : u.user_name,
          u.person.name.nil? ? "" : u.person.name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_mail_logs_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]
  

    sortname ? sortname : "id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    conditions = Array.new
    values = Array.new

    conditions << "mail_logs.entity_type =?"
    values << "Person"

    conditions << "mail_logs.created_at Between ? And ?"
    values << "#{Date.today().last_year.yesterday.to_s}".to_date
    values << "#{Date.today().tomorrow.to_s}".to_date

    conditions << "mail_logs.creator_id =?"
    values << @current_user.id


    #No search terms provided
    if(query == "%%")
      @mail_logs = MailLog.find(
        :all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start,
        :joins => "INNER JOIN people ON people.id = mail_logs.entity_id",
        :include => ["creator", "person_mail_template"]

      )
      count = MailLog.count(:all,  :conditions => [conditions.join(' AND '), *values], :joins => "INNER JOIN people ON people.id = mail_logs.entity_id", :include => ["creator", "person_mail_template"])
    

    end

    if(query != "%%")
      @mail_logs = MailLog.find(
        :all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :include => ["creator", "person_mail_template"])
      count = MailLog.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values], :joins => "INNER JOIN people ON people.id = mail_logs.entity_id", :include => ["creator", "person_mail_template"])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @mail_logs.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.entity.full_name,
          u.channel,
          u.person_mail_template.name,
          u.creator.user_name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end



  def show_org_mail_logs_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]


    sortname ? sortname : "id"
    sortorder ? sortorder : "asc"
    page ? page : 1
    rp ? rp : 10

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"

    conditions = Array.new
    values = Array.new

    conditions << "mail_logs.entity_type =?"
    values << "Organisation"

    conditions << "mail_logs.created_at Between ? And ?"
    values << "#{Date.today().last_year.yesterday.to_s}".to_date
    values << "#{Date.today().tomorrow.to_s}".to_date

    conditions << "mail_logs.creator_id =?"
    values << @current_user.id

    #No search terms provided
    if(query == "%%")
      @mail_logs = MailLog.find(
        :all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname + ' ' + sortorder,
        :limit => rp,
        :offset => start,
        :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id",
        :include => ["creator", "organisation_mail_template"]

      )
      count = MailLog.count(:all, :conditions => [conditions.join(' AND '), *values], :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id", :include => ["creator", "organisation_mail_template"])
    end

    if(query != "%%")
      @mail_logs = MailLog.find(
        :all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :include => ["creator", "organisation_mail_template"])
      count = MailLog.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values], :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id", :include => ["creator", "organisation_mail_template"])
    end

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @mail_logs.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.entity.full_name,
          u.channel,
          u.organisation_mail_template.name,
          u.creator.user_name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_existing_query_grid
    page=(params[:page]).to_i
    rp = (params[:rp]).to_i
    query = params[:query]
    qtype = params[:qtype]
    sortname = params[:sortname]
    sortorder = params[:sortorder]

    query_type = params[:query_type]

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

    #No search terms provided
    
    @saved_queries = query_type.constantize.find(
      :all,
      :conditions => ["query_headers.group = ?", "save"],
      :order => sortname + ' ' + sortorder,
      :limit => rp,
      :offset => start
    )
    count = query_type.constantize.count(:all, :conditions=>["query_headers.group = ?", "save"])

    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @saved_queries.collect{|u| {
        :id => u.id,
        :cell => [
          u.id,
          u.name,
          u.description
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end

  def show_person_maillog_enquiry_grid
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

    conditions << "mail_logs.entity_type =?"
    values << "Person"

    if params[:entity_id]
      conditions << "mail_logs.entity_id =?"
      values << params[:entity_id]
    end


    if params[:start_date]
      conditions << "mail_logs.created_at Between ? And ?"
      values << params[:start_date].to_date
      values << params[:end_date].to_date
    end

    if params[:creator_id]
      conditions << "mail_logs.creator_id =?"
      values << params[:creator_id]
      
    end

    # No search terms provided
    if(query == "%%")
      @mail_logs = MailLog.find(:all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :joins => "INNER JOIN people ON people.id = mail_logs.entity_id",
        :include => ["creator", "person_mail_template"]
      )
      count = MailLog.count(:all, :conditions => [conditions.join(' AND '), *values],
        :joins => "INNER JOIN people ON people.id = mail_logs.entity_id",
        :include => ["creator", "person_mail_template"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @mail_logs = MailLog.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :joins => "INNER JOIN people ON people.id = mail_logs.entity_id",
        :include => ["creator", "person_mail_template"])
      count = MailLog.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :joins => "INNER JOIN people ON people.id = mail_logs.entity_id",
        :include => ["creator", "person_mail_template"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @mail_logs.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.entity.full_name,
          u.channel,
          u.person_mail_template.name,
          u.creator.user_name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false
  end


  def show_organisation_maillog_enquiry_grid

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

    conditions << "mail_logs.entity_type =?"
    values << "Organisation"

    if params[:entity_id]
      conditions << "mail_logs.entity_id =?"
      values << params[:entity_id]
    end


    if params[:start_date]
      conditions << "mail_logs.created_at Between ? And ?"
      values << params[:start_date].to_date
      values << params[:end_date].to_date
    end

    if params[:creator_id]
      conditions << "mail_logs.creator_id =?"
      values << params[:creator_id]

    end

    # No search terms provided
    if(query == "%%")
      @mail_logs = MailLog.find(:all,
        :conditions => [conditions.join(' AND '), *values],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id",
        :include => ["creator", "organisation_mail_template"]

      )
      count = MailLog.count(:all, :conditions => [conditions.join(' AND '), *values],
        :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id",
        :include => ["creator", "organisation_mail_template"]
      )
    end

    # User provided search terms
    if(query != "%%")
      @mail_logs = MailLog.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id",
        :include => ["creator", "organisation_mail_template"])
      count = MailLog.count(:all, :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values],
        :joins => "INNER JOIN organisations ON organisations.id = mail_logs.entity_id",
        :include => ["creator", "organisation_mail_template"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @mail_logs.collect{|u| {
        :id => u.id,
        :cell => [
          u.id.nil? ? "" : u.id,
          u.entity.full_name,
          u.channel,
          u.organisation_mail_template.name,
          u.creator.user_name
        ]
      }}
    render :text=>return_data.to_json, :layout=>false

  end


  def show_banks_grid
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
      @banks = Bank.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["country"]
      )
      count = Bank.count(:all, :include => ["country"])
    end

    # User provided search terms
    if(query != "%%")
      @banks = Bank.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["country"])
      count = Bank.count(:all, :conditions=>[qtype +" ilike ?", query],  :include => ["country"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @banks.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.full_name,
          u.short_name,
          u.branch_name,
          u.branch_number,
          u.state,
          u.postcode,
          u.country_id.nil? ? "" : u.country.short_name,
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end


  def show_tax_items_grid
    page = (params[:page]).to_i
    rp =(params[:rp]).to_i
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

    start = ((page -1) * rp).to_i
    query = "%"+query+"%"




    # No search terms provided
    if(query == "%%")
      @tax_items = TaxItem.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
       
      )
      count = TaxItem.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @tax_items = TaxItem.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query]
      )
      count = TaxItem.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @tax_items.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.to_be_removed ? "<span class='red'>"+u.name+"</span>" : u.name,
          u.to_be_removed ? "<span class='red'>"+u.description+"</span>" : u.description,
          u.to_be_removed ? "<span class='red'>"+u.percentage.to_s+"</span>" : u.percentage,
          u.to_be_removed ? "<span class='red'>"+u.active.to_s+"</span>" : u.active,

        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end



  def show_intiate_membership_grid
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

   params[:type]=params[:type].split(",") rescue params[:type] = params[:type]

    start = ((page-1) * rp).to_i
    query = "%"+query+"%"


     conditions = Array.new
    values = Array.new

    conditions << "membership_status_id IN (?)"
    values << params[:type]

    if params[:start_date]
      conditions << "created_at >= ? "
      values << params[:start_date]
    end

    if params[:end_date]
      conditions << "created_at >= ? "
      values << params[:end_date]
    end

    if params[:creator_id]
      conditions << "creator_id = ? "
      values << params[:creator_id]
    end


    # No search terms provided
    if(query == "%%")
      @membership = Membership.find(:all,
        :conditions=>[ conditions.join(' AND '), *values],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start

      )
      count = Membership.count(:all, :conditions=>[ conditions.join(' AND '), *values])
    end

    # User provided search terms
    if(query != "%%")
      @membership = Membership.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values]
      )
      count = Membership.count(:all,:conditions=>[qtype +" ilike ? AND " + conditions.join(' AND '), query, *values])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @membership.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.person_id,
          u.employer_id,
          u.workplace_id,
          u.membership_status_id,
          u.membership_type_id,

        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end

  def show_memberships_grid
    page = (params[:page]).to_i
    rp =(params[:rp]).to_i
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

    start = ((page -1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @membership = Membership.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = Membership.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @membership = Membership.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query]
      )
      count = Membership.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @membership.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description,
          u.percentage,
          u.active
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end


  def  show_fee_grid


    page = (params[:page]).to_i
    rp =(params[:rp]).to_i
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

    start = ((page -1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @fee_items = params[:type].camelize.constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start

      )
      count = params[:type].camelize.constantize.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @fee_items = params[:type].camelize.constantize.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query]
      )
      count = params[:type].camelize.constantize.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @fee_items.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description,          
          u.gl_code,
          u.starting_date.getlocal.to_date.to_s,
          u.ending_date.getlocal.to_date.to_s,
          u.type,
          u.active
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
   
  end

  def show_default_value_grid

    page = (params[:page]).to_i
    rp =(params[:rp]).to_i
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

    start = ((page -1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @default_values = UserPreference.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions => ["login_account_id=?", "#{@current_user.id}"],
        :include => ["login_account", "default_address_type"]

      )
      count = UserPreference.count(:all, :conditions => ["login_account_id=?", "#{@current_user.id}"], :include => ["login_account", "default_address_type"] )
    end

    # User provided search terms
    if(query != "%%")
      @default_values = UserPreference.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?  AND login_account_id=?", query, "#{@current_user.id}"]
      )
      count = UserPreference.count(:all, :conditions=>[qtype +" ilike ? AND login_account_id=?", query, "#{@current_user.id}"], :include => ["login_account", "default_address_type"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @default_values.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.login_account.user_name,
          u.start_date,
          u.end_date,
          u.default_address_type.name
#          u.default_first_title.name,
#          u.default_nationality.name,
#          u.default_language.name,
#          u.default_phone_type.name,
#          u.default_email_type.name,
#          u.default_website_type.name,
#          u.default_note_type.name,


        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

  end



   def show_membership_fee_grid

    page = (params[:page]).to_i
    rp =(params[:rp]).to_i
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

    start = ((page -1) * rp).to_i
    query = "%"+query+"%"

    # No search terms provided
    if(query == "%%")
      @membership_fee = MembershipFee.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions => ["membership_id=?", params[:membership_id]]
      )
      count = MembershipFee.count(:all, :conditions => ["membership_id=?", params[:membership_id]] )
    end

    # User provided search terms
    if(query != "%%")
      @membership_fee = MembershipFee.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?  AND membership_id=?", query, params[:membership_id]],
        :include => ["fee_item","payment_method_type","membership","receipt_account"]
      )
      count = MembershipFee.count(:all, :conditions=>[qtype +" ilike ? AND membership_id=?", query, params[:membership_id]],:include => ["fee_item","payment_method_type","membership","receipt_account"] )
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @membership_fee.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.fee_item.name,
          u.membership.person.name,
          u.payment_method_type.name,
          u.receipt_account.name

        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false

   end
end