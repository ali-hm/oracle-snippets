select dependant_tables.table_name
      ,dependant_tables.constraint_name
      ,dependant_tables.delete_rule
      ,dependant_tables.status
      ,cons_cols.column_name
    from
        (select table_name
              ,constraint_name
              ,delete_rule
              ,status
            from all_constraints 
            where constraint_type = 'R' 
                  and owner = upper(:owner) 
                  and r_constraint_name in (
                                            select constraint_name 
                                              from all_constraints 
                                              where constraint_type = 'P' 
                                                    and owner = upper(:owner) 
                                                    and table_name = upper(:table_name)
                                            )
        )dependant_tables
        join
        (select * from all_cons_columns
          where owner = upper(:owner) 
        )cons_cols on cons_cols.constraint_name=dependant_tables.constraint_name