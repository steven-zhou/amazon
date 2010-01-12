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
      count = PeopleSearchGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = FeedbackSearchGrid.count(:all,
        :conditions=>[qtype +" ilike ? ", query ])
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
      count = SystemLogSearchGrid.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLogSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query ])
      count = SystemLogSearchGrid.count(:all,
        :conditions=>[qtype +" ilike ? ", query])
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
      count = SystemLogArchiveGrid.count(:all, :conditions => [])
    end

    # User provided search terms
    if(query != "%%")
      @system_log_entries = SystemLogArchiveGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? ", query ])
      count = SystemLogArchiveGrid.count(:all,
        :conditions=>[qtype +" ilike ? ", query])
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
      count = OrganisationSearchGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      @people = QueryResultGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = QueryResultGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @people = QueryResultGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = QueryResultGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      @people = ListEditGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )
      count = ListEditGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])
    end

    # User provided search terms
    if(query != "%%")
      @people = ListEditGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
      count = ListEditGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ListCompileGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

      count = ShowOtherGroupOrganisationsGrid.count(:all,

        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = OrganisationEmployeeGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ShowOtherGroupMemberGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = OrganisationEmployeeGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

      count = DuplicationPersonalGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
    	count = DuplicationOrganisationsGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

      count = PersonContactsReportGrid.count(:all,

        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

      count = OgansisationContactsReportGrid.count(:all,

        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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

    # No search terms provided
    if(query == "%%")
      @show_postcode = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :include => ["country"]

      )

      count = Postcode.count(:all,:include => ["country"])

    end

    # User provided search terms
    if(query != "%%")

      @show_postcode = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["country"])

      count = Postcode.count(:all, :conditions=>[qtype +" ilike ?", query],:include => ["country"])
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
#          u.country_name
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
      count = ShowListGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = ShowOrganisationListGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = PersonLookupGrid.count(:all,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
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
      count = Country.count(:all,:include => ["main_language"])
    end

    # User provided search terms
    if(query != "%%")
      @country = Country.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query],
        :include => ["main_language"])
      count = Country.count(:all, :conditions=>[qtype +" ilike ?", query],:include => ["main_language"])
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
      count = Campaign.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @campaign = Campaign.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = Campaign.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @campaign.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description,
          u.target_amount,
          u.start_date.nil? ? '' : u.start_date.strftime('%d-%m-%Y'),
          u.end_date.nil? ? '' : u.end_date.strftime('%d-%m-%Y'),
          (u.status? ? 'Active' : 'Inactive'),
          u.remarks
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
      count = Language.count(:all)
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
#          u.country_id,
#          u.country_name,
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
      count = Religion.count(:all)
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
#          u.country_id,
#          u.country_name,
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

      count = Postcode.count(:all, :conditions => ["postcodes.country_id = ?", session[:postcode_country_id]],:include => ["geographical_area","electoral_area"])

    end

    # User provided search terms
    if(query != "%%")
      @postcodes = Postcode.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND postcodes.country_id = ?", query, session[:postcode_country_id]],
        :include => relatedb)
       

      count = Postcode.count(:all,:conditions=>[qtype +" ilike ? AND postcodes.country_id = ?", query, session[:postcode_country_id]],:include => relatedb)
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
#          u.geo_area,
          u.geographical_area_id.nil? ? "" : u.geographical_area.division_name,
#          u.elec_area
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
        :conditions => ["campaign_id = ?", session[:source_campaign_id]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )

      count = Source.count(:all, :conditions => ["campaign_id = ?", session[:source_campaign_id]])

    end

    # User provided search terms
    if(query != "%%")

      @sources = Source.find(:all,

        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND campaign_id = ?", query, session[:source_campaign_id]])

      count = Postcode.count(:all,

        :conditions=>[qtype +" ilike ? AND campaign_id = ?", query, session[:source_campaign_id]])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @sources.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.description,
          u.volume,
          u.cost,
          (u.status? ? 'Active' : 'Inactive')
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
        :cell=>[u.id,
          u.name,
          u.description,
          u.link_module_id.nil? ? "" : (LinkModule.find(u.link_module_id).to_be_removed? ? "<span class='red'>"+u.link_module.name+"</span>" : u.link_module.name),
          u.post_to_history,
          u.post_to_campaign,
          u.send_receipt,
          (u.status? ? 'Active' : 'Inactive'),
          u.remarks]}}
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
      count = ReceiptMethod.count(:all)
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
      count = ClientBankAccount.count(:all, :include => ["account_purpose", "bank"])
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
        :cell=>[u.id,
          u.bank_id.nil? ? "" : u.bank.display_name,
          u.account_number,
          u.account_purpose_id.nil? ? "" : (AccountPurpose.find(u.account_purpose_id).to_be_removed? ? "<span class='red'>"+u.account_purpose.name+ "</span>" : u.account_purpose.name),
          (u.status? ? 'Active' : 'Inactive')
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
      count = PersonBankAccount.count(:all)
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
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"]
      )
      count = TransactionHeader.count(:all, :conditions => ["transaction_headers.entity_id=? and entity_type=? and banked=?", params[:entity_id], params[:entity_type], false], :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and entity_type=? and banked=?", query, params[:entity_id], params[:entity_type], false],
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
      count = TransactionHeader.count(:all, :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and entity_type=? and banked=?", query, params[:entity_id], params[:entity_type], false], :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_number,
          u.transaction_date,
          u.bank_account_id.nil? ? "" : u.bank_account.account_number,
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
      count = TransactionHeader.count(:all, :conditions => ["transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date], :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
    end

    # User provided search terms
    if(query != "%%")
      @transaction = TransactionHeader.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", query, params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date],
        :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
      count = TransactionHeader.count(:all, :conditions=>[qtype +" ilike ? AND transaction_headers.entity_id=? and transaction_headers.entity_type=? and transaction_headers.banked=? and transaction_headers.transaction_date >= ? and transaction_headers.transaction_date <= ?", query, params[:entity_id], params[:entity_type], true, params[:start_date].to_date, params[:end_date].to_date], :include => ["bank_account", "receipt_meta_meta_type", "receipt_meta_type"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_number,
          u.transaction_date,
          u.bank_account_id.nil? ? "" : u.bank_account.account_number,
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
      count = TempTransactionAllocationGrid.count(:all, :conditions => ["login_account_id=?",  @current_user])
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
      count = TransactionAllocation.count(:all, :conditions => ["transaction_header_id=?",  params[:transaction_header_id]], :include => ["campaign", "receipt_account", "source"])
    end

    # User provided search terms
    if(query != "%%")
      @transaction_allocations = TransactionAllocation.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND transaction_header_id=?", query, params[:transaction_header_id]],
        :include => ["campaign", "receipt_account", "source"])
      count = TransactionAllocation.count(:all, :conditions=>[qtype +" ilike ? AND transaction_header_id=?", query, params[:transaction_header_id]], :include => ["campaign", "receipt_account", "source"])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count
    return_data[:rows] = @transaction_allocations.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.receipt_account_id.nil? ? "" : u.receipt_account.name,
          u.campaign_id.nil? ? "" : u.campaign.name,
          u.source_id.nil? ? "" : u.source.name,
          u.letter_id.nil? ? "" : u.letter_id,
          u.amount.nil? ? "$0.00" : currencify(u.amount)
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
      @email_maintenance = EmailSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )

      count = EmailSearchGrid.count(:all)

    end

    # User provided search terms
    if(query != "%%")

      @email_maintenance = EmailSearchGrid.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])

      count = EmailSearchGrid.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @email_maintenance.collect{|u| {:id => u.grid_object_id,
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
      count = MessageTemplate.count(:all)
    end

    # User provided search terms
    if(query != "%%")
      @message_templates = MessageTemplate.find(:all,
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ?", query])
      count = MessageTemplate.count(:all, :conditions=>[qtype +" ilike ?", query])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count

    return_data[:rows] = @message_templates.collect{|u| {:id => u.id,
        :cell=>[u.id,
          u.name,
          u.created_at.strftime('%d-%m-%Y')
        ]}}
    # Convert the hash to a json object
    render :text=>return_data.to_json, :layout=>false
  end

end


