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
      @show_postcode = ShowPostcodeGrid.find(:all,
        :conditions => ["login_account_id = ?", session[:user]],
        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start
      )

      count = ShowPostcodeGrid.count(:all, :conditions => ["login_account_id = ?", session[:user]])

    end

    # User provided search terms
    if(query != "%%")

      @show_postcode = ShowPostcodeGrid.find(:all,

        :order => sortname+' '+sortorder,
        :limit =>rp,
        :offset =>start,
        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])

      count = ShowPostcodeGrid.count(:all,

        :conditions=>[qtype +" ilike ? AND login_account_id = ?", query, session[:user]])
    end

    # Construct a hash from the ActiveRecord result
    return_data = Hash.new()
    return_data[:page] = page
    return_data[:total] = count


    return_data[:rows] = @show_postcode.collect{|u| {:id => u.grid_object_id,
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
end
