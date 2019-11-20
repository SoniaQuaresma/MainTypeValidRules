-- Procedure to execute the validation rules
-- that must be present and parameterized in table VTLCTRL

CREATE OR REPLACE PROCEDURE P_VALIDA  (num IN NUMBER) IS

v_VTLCTRL VTLCTRL%rowtype;

v_select varchar2(10000);
v_table_name varchar2(1000);
v_exist number;

BEGIN

SELECT * INTO v_VTLCTRL FROM VTLCTRL where id=num;

v_table_name := 'TLOG_' ||v_VTLCTRL.tbl_dsd ||'_'|| v_VTLCTRL.type;

IF UPPER(v_VTLCTRL.type)= 'FDL' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    SELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_FDL';
    If v_VTLCTRL.sub_type = 'Normal' then   
            if v_exist<=0 then      
                    v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ')=' ||v_VTLCTRL.val1 || ' THEN ''true''
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ')<>' ||v_VTLCTRL.val1 || ' THEN ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') = ' ||v_VTLCTRL.val1 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be ' ||v_VTLCTRL.val1 || ' characters''  END AS ERRORCODE,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') = ' ||v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                    execute immediate v_select;
                    
                    v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                    execute immediate v_select;
            else
                    v_select:='insert into ' ||v_table_name  ||'  SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ')=' ||v_VTLCTRL.val1 || ' THEN ''true''
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ')<>' ||v_VTLCTRL.val1 || ' THEN ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') = ' ||v_VTLCTRL.val1 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be ' ||v_VTLCTRL.val1 || ' characters''  END AS ERRORCODE,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') = ' ||v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                    execute immediate v_select;
                    commit;       
            end if;        
    elsif  v_VTLCTRL.sub_type = 'Empty' then
            if v_exist<=0 then       
                     v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) =' ||v_VTLCTRL.val1 || ' THEN ''true''
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) <>' ||v_VTLCTRL.val1 || ' THEN ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be ' ||v_VTLCTRL.val1 || ' characters or Empty''  END AS ERRORCODE,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                    execute immediate v_select;
                            
                    v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                    execute immediate v_select;
            else
                    v_select:='insert into ' ||v_table_name  ||'  SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ',  
                    CASE 
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) =' ||v_VTLCTRL.val1 || ' THEN ''true''
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) <>' ||v_VTLCTRL.val1 || ' THEN ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be ' ||v_VTLCTRL.val1 || ' characters or Empty''  END AS ERRORCODE,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;     
                    execute immediate v_select;    
                    commit;                        
         end if;   
    elsif  v_VTLCTRL.sub_type = 'Decimal' then
            if v_exist<=0 then       
                     v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR INSTR(' ||v_VTLCTRL.chk_fld1 || ','','')=0 OR LENGTH(' ||v_VTLCTRL.chk_fld1 || ') - INSTR(' ||v_VTLCTRL.chk_fld1 || ','','') <= ' ||v_VTLCTRL.val1 || ' THEN ''true''
                        ELSE ''false'' END  AS BOOL_VAR,
                    CASE 
                       WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NOT NULL AND NOT INSTR(' ||v_VTLCTRL.chk_fld1 || ','','')=0 AND LENGTH(' ||v_VTLCTRL.chk_fld1 || ') - INSTR(' ||v_VTLCTRL.chk_fld1 || ','','') > ' ||v_VTLCTRL.val1 || ' THEN ''Observation value must be an integer or have just ' ||v_VTLCTRL.val1 || ' decimal ''  END AS ERRORCODE,
                    CASE 
                        WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NOT NULL AND NOT INSTR(' ||v_VTLCTRL.chk_fld1 || ','','')=0 AND LENGTH(' ||v_VTLCTRL.chk_fld1 || ') - INSTR(' ||v_VTLCTRL.chk_fld1 || ','','') > ' ||v_VTLCTRL.val1 || ' THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                                            dbms_output.put_line(v_select);    
                    execute immediate v_select;
                            
                    v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                    execute immediate v_select;
            else
                    v_select:='insert into ' ||v_table_name  ||'  SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ',  
                    CASE 
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) =' ||v_VTLCTRL.val1 || ' THEN ''true''
                        WHEN length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0)) <>' ||v_VTLCTRL.val1 || ' THEN ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be ' ||v_VTLCTRL.val1 || ' characters or Empty''  END AS ERRORCODE,
                    CASE 
                        WHEN NOT (' || v_VTLCTRL.chk_fld1 || ' IS NULL OR length(nvl(' ||v_VTLCTRL.chk_fld1 || ',0))  = ' ||v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;     
                    execute immediate v_select;    
                    commit;                        
         end if;                            
    elsif  v_VTLCTRL.sub_type = 'Between' then
            if v_exist<=0 then         
                    v_select:='create table ' ||v_table_name  ||'as  SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ' THEN ''true''
                        ELSE ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be between ' ||v_VTLCTRL.val1 || ' and ' ||v_VTLCTRL.val2 || ' characters''  END AS ERRORCODE,
                    CASE 
                       WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                    execute immediate v_select;
                                
                    v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                    execute immediate v_select;  
             else
                    v_select:='insert into ' ||v_table_name  ||'  SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                    CASE 
                        WHEN length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ' THEN ''true''
                        ELSE ''false'' END  AS BOOL_VAR,
                    CASE 
                        WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' length should be between ' ||v_VTLCTRL.val1 || ' and ' ||v_VTLCTRL.val2 || ' characters''  END AS ERRORCODE,
                    CASE 
                       WHEN NOT (length(' ||v_VTLCTRL.chk_fld1 || ') Between ' ||v_VTLCTRL.val1 || ' AND ' || v_VTLCTRL.val2 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                    FROM ' ||v_VTLCTRL.tbl_dsd;
                    execute immediate v_select;
                    commit;              
            end if;                                                                    
    end if;                    
   
ELSIF UPPER(v_VTLCTRL.type)= 'FDM' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    SELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_FDM';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''false''
               ELSE ''true'' END  AS BOOL_VAR,
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' should not be empty when  ' ||v_VTLCTRL.chk_fld2 ||  ' not in ' ||replace(v_VTLCTRL.val_list,'''','') || ''' END AS ERRORCODE,
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM ' ||v_VTLCTRL.tbl_dsd;
            execute immediate v_select; 
                        
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''false''
               ELSE ''true'' END  AS BOOL_VAR,
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' should not be empty when  ' ||v_VTLCTRL.chk_fld2 ||  ' not in ' ||replace(v_VTLCTRL.val_list,'''','') || ''' END AS ERRORCODE,
            CASE 
                WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL AND NVL(' ||v_VTLCTRL.chk_fld2 || ',0) NOT IN (' || v_VTLCTRL.val_list || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM ' ||v_VTLCTRL.tbl_dsd;
            execute immediate v_select;
            commit;                             
     end if;     



ELSIF UPPER(v_VTLCTRL.type)= 'COV' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    SELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_COV';
 
    if v_VTLCTRL.val_list is not null THEN   
        if v_exist<=0 then
                v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ') THEN ''true''
                   ELSE ''false'' END  AS BOOL_VAR,
                CASE 
                   WHEN NOT(' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ')) THEN ''' ||v_VTLCTRL.chk_fld1 || ' is not in the valid list of codes'' END AS ERRORCODE,
                CASE 
                    WHEN NOT(' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ')) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                FROM ' ||v_VTLCTRL.tbl_dsd;
                execute immediate v_select; 
                            
                 v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                 execute immediate v_select;              
        else
                v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ') THEN ''true''
                   ELSE ''false'' END  AS BOOL_VAR,
                CASE 
                   WHEN NOT(' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ')) THEN ''' ||v_VTLCTRL.chk_fld1 || ' is not in the valid list of codes'' END AS ERRORCODE,
                CASE 
                    WHEN NOT(' ||v_VTLCTRL.chk_fld1 || ' IS NULL OR ' ||v_VTLCTRL.chk_fld1 || ' IN (' || v_VTLCTRL.val_list || ')) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                FROM ' ||v_VTLCTRL.tbl_dsd;
                execute immediate v_select;
                commit;                             
         end if;     
    else   
        if v_exist<=0 then
                v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''false''
                   ELSE ''true'' END  AS BOOL_VAR,
                CASE 
                   WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' is not valid'' END AS ERRORCODE,
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                FROM ' ||v_VTLCTRL.tbl_dsd;
                execute immediate v_select; 
                            
                 v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
                 execute immediate v_select;              
        else
                v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''false''
                   ELSE ''true'' END  AS BOOL_VAR,
                CASE 
                   WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''' ||v_VTLCTRL.chk_fld1 || ' is not valid'' END AS ERRORCODE,
                CASE 
                    WHEN ' ||v_VTLCTRL.chk_fld1 || ' NOT IN ( SELECT ' || v_VTLCTRL.tbl_codes_fld || ' FROM ' ||  v_VTLCTRL.tbl_codes || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
                FROM ' ||v_VTLCTRL.tbl_dsd;
                execute immediate v_select;
                commit;                             
         end if;     
    end if;     
    
ELSIF UPPER(v_VTLCTRL.type)= 'RDW' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_RDW';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN B.key_num IS NULL THEN ''true'' else ''false'' END  AS BOOL_VAR,
            CASE
                WHEN not(B.key_num IS NULL) THEN ''Duplicate keys found'' END AS ERRORCODE,
            CASE    
                WHEN not(B.key_num IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A) A,
            (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, COUNT(1) key_num FROM  '  ||v_VTLCTRL.tbl_dsd || ' 
            GROUP BY ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' HAVING COUNT(1)>1) B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select; 
                        
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN B.key_num IS NULL THEN ''true'' else ''false'' END  AS BOOL_VAR,
            CASE
                WHEN not(B.key_num IS NULL) THEN ''Duplicate keys found'' END AS ERRORCODE,
            CASE    
                WHEN not(B.key_num IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A) A,
            (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, COUNT(1) key_num FROM  '  ||v_VTLCTRL.tbl_dsd || ' 
            GROUP BY ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' HAVING COUNT(1)>1) B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select;
            commit;                             
     end if;   
     
ELSIF UPPER(v_VTLCTRL.type)= 'RNR' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_RNR';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || '  THEN ''true'' else ''false'' END  AS BOOL_VAR,
            CASE
                WHEN not(B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ') THEN ''Nº of records for each period should be between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ' '' END AS ERRORCODE,
            CASE    
                WHEN not(B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM (SELECT DISTINCT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, '|| v_VTLCTRL.key_list || ' FROM '  ||v_VTLCTRL.tbl_dsd || ' A) A,
            (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, COUNT(1) int_var FROM  '  ||v_VTLCTRL.tbl_dsd || ' 
            GROUP BY ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' ) B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select; 
                        
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || '  THEN ''true'' else ''false'' END  AS BOOL_VAR,
            CASE
                WHEN not(B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ') THEN ''Nº of records for each period should be between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ' '' END AS ERRORCODE,
            CASE    
                WHEN not(B.int_var between ' || v_VTLCTRL.val1|| ' AND ' || v_VTLCTRL.val2 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM (SELECT DISTINCT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, '|| v_VTLCTRL.key_list || ' FROM '  ||v_VTLCTRL.tbl_dsd || ' A) A,
            (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, COUNT(1) int_var FROM  '  ||v_VTLCTRL.tbl_dsd || ' 
            GROUP BY ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' ) B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select;
            commit;                             
     end if;           


ELSIF UPPER(v_VTLCTRL.type)= 'COC' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_COC';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' || v_VTLCTRL.tbl_codes || ' b) THEN ''false'' END  AS BOOL_VAR,
            CASE
                WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' || v_VTLCTRL.tbl_codes || ' b) THEN ''Combination of Freq, DIM_CL_H_GIPCAT not possible '' END AS ERRORCODE,
            CASE    
                 WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' || v_VTLCTRL.tbl_codes || ' b) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM  '  ||v_VTLCTRL.tbl_dsd; 
            execute immediate v_select; 
                        
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' || v_VTLCTRL.tbl_codes || ' b) THEN ''false'' END  AS BOOL_VAR,
            CASE
                WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' || v_VTLCTRL.tbl_codes || ' b) THEN ''Combination of Freq, DIM_CL_H_GIPCAT not possible '' END AS ERRORCODE,
            CASE    
                 WHEN ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' NOT IN (Select   ' || REPLACE(v_VTLCTRL.tbl_codes_fld,',','||') || '  from ' ||v_VTLCTRL.tbl_codes || ' b) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM  '  ||v_VTLCTRL.tbl_dsd; 
            execute immediate v_select;
            commit;                             
     end if;    
     
ELSIF UPPER(v_VTLCTRL.type)= 'VIR' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_VIR';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN ' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ' THEN ''true'' ELSE ''false'' END  AS BOOL_VAR,
            CASE
                WHEN NOT(' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ') THEN ''Values of '  || v_VTLCTRL.VAL_LIST ||  ' for '   || v_VTLCTRL.val3 ||   ' should be between '   || v_VTLCTRL.val1 ||   ' and '   || v_VTLCTRL.val2 ||  ''' END AS ERRORCODE,
            CASE    
                                 WHEN NOT(' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM  '  ||v_VTLCTRL.tbl_dsd || ' WHERE '  ||v_VTLCTRL.chk_fld2 || ' = '''  ||v_VTLCTRL.VAL_LIST || ''' AND '  ||v_VTLCTRL.chk_fld3 || ' = '''  ||v_VTLCTRL.val3 || '''';
            execute immediate v_select; 
                        
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num || ' as ID,'|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN ' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ' THEN ''true'' ELSE ''false'' END  AS BOOL_VAR,
            CASE
                WHEN NOT(' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ') THEN ''Values of '  || v_VTLCTRL.VAL_LIST ||  ' for '   || v_VTLCTRL.val3 ||   ' should be between '   || v_VTLCTRL.val1 ||   ' and '   || v_VTLCTRL.val2 ||  ''' END AS ERRORCODE,
            CASE    
                                 WHEN NOT(' || v_VTLCTRL.chk_fld1|| ' BETWEEN ' || v_VTLCTRL.val1 || ' and ' ||  v_VTLCTRL.val2|| ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM  '  ||v_VTLCTRL.tbl_dsd || ' WHERE '  ||v_VTLCTRL.chk_fld2 || ' = '''  ||v_VTLCTRL.VAL_LIST || ''' AND '  ||v_VTLCTRL.chk_fld3 || ' = '''  ||v_VTLCTRL.val3 || '''';
            execute immediate v_select;
            commit;                             
     end if;    

ELSIF UPPER(v_VTLCTRL.type)= 'VCO' THEN

    --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_VCO';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''false'' else ''true'' END  AS BOOL_VAR,
                        CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''Values of '|| v_VTLCTRL.val3 || ' should not be less then '|| to_number(v_VTLCTRL.val1) || '% of ' || v_VTLCTRL.val2 ||'.'' END AS ERRORCODE,
            CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val2 || ''') A,
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY,'|| v_VTLCTRL.chk_fld1|| ' FROM  '  ||v_VTLCTRL.tbl_dsd || ' B WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val3 || ''') B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select; 
               
             v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
             execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''false'' else ''true'' END  AS BOOL_VAR,
                        CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''Values of '|| v_VTLCTRL.val3 || ' should not be less then '|| to_number(v_VTLCTRL.val1) || '% of ' || v_VTLCTRL.val2 ||'.'' END AS ERRORCODE,
            CASE
                WHEN A.'|| v_VTLCTRL.chk_fld1|| ' < '|| to_number(v_VTLCTRL.val1) || '*B.'|| v_VTLCTRL.chk_fld1|| '/100 THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val2 || ''') A,
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY,'|| v_VTLCTRL.chk_fld1|| ' FROM  '  ||v_VTLCTRL.tbl_dsd || ' B WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val3 || ''') B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select;
            commit;                             
     end if;         



ELSIF UPPER(v_VTLCTRL.type)= 'VAD' THEN

     --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_VAD';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''true'' else ''false'' END  AS BOOL_VAR,
                        CASE
                WHEN NOT (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''Value of '|| v_VTLCTRL.val2 || ' should be equal to '|| replace(v_VTLCTRL.val_List,'''','') || ' more or less 1 '' END AS ERRORCODE,
            CASE
                WHEN NOT (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, sum('|| v_VTLCTRL.chk_fld1|| ') as ov, '|| v_VTLCTRL.key_list|| 
                ' FROM '  ||v_VTLCTRL.tbl_dsd || ' A WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val2 || ''' group by ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' , '|| v_VTLCTRL.key_list|| ') A,
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, sum(' || v_VTLCTRL.chk_fld1|| ') as ov 
                  FROM  ' ||v_VTLCTRL.tbl_dsd || ' B WHERE '  ||v_VTLCTRL.chk_fld2 || ' in ( '  ||v_VTLCTRL.val_List || ') group by ' || REPLACE(v_VTLCTRL.key_list,',','||') || ') B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select; 
                        
            v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
            execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''true'' else ''false'' END  AS BOOL_VAR,
                        CASE
                WHEN NOT (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''Value of '|| v_VTLCTRL.val2 || ' should be equal to '|| replace(v_VTLCTRL.val_List,'''','') || ' more or less 1 '' END AS ERRORCODE,
            CASE
                WHEN NOT (A.ov < b.ov + '|| v_VTLCTRL.val1|| ' and a.ov > b.ov - '|| v_VTLCTRL.val1 || ') THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, sum('|| v_VTLCTRL.chk_fld1|| ') as ov, '|| v_VTLCTRL.key_list|| 
                ' FROM '  ||v_VTLCTRL.tbl_dsd || ' A WHERE '  ||v_VTLCTRL.chk_fld2 || '= '''  ||v_VTLCTRL.val2 || ''' group by ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' , '|| v_VTLCTRL.key_list|| ') A,
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' as KEY, sum(' || v_VTLCTRL.chk_fld1|| ') as ov 
                  FROM  ' ||v_VTLCTRL.tbl_dsd || ' B WHERE '  ||v_VTLCTRL.chk_fld2 || ' in ( '  ||v_VTLCTRL.val_List || ') group by ' || REPLACE(v_VTLCTRL.key_list,',','||') || ') B
            WHERE A.KEY=B.KEY(+)';
            execute immediate v_select;
            commit;                             
     end if;      
     
ELSIF UPPER(v_VTLCTRL.type)= 'REP' THEN

     --SELECT count(*) into v_exist FROM tab  where tname = v_table_name;
    sELECT count(*) into v_exist FROM tab  where tname = 'TLOG_ANI_GIPCAT_S_2016_REP';
  
    if v_exist<=0 then
            v_select:='create table ' ||v_table_name  ||' as 
            SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (B.val IS NULL) THEN ''false'' else ''true'' END  AS BOOL_VAR,
            CASE    
                WHEN (B.val IS NULL) THEN  ''If '|| v_VTLCTRL.val1 || ' is provided  '|| v_VTLCTRL.val2 || ' should be provided too '' END AS ERRORCODE,
            CASE
                WHEN (B.val IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val1 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') A,
               (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, 1 val FROM '  ||v_VTLCTRL.tbl_dsd || ' B 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val2 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') B
            WHERE A.KEY=B.KEY(+)
            UNION
            SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (A.val IS NULL) THEN ''false'' else ''true'' END  AS BOOL_VAR,
            CASE    
                WHEN (A.val IS NULL) THEN  ''If '|| v_VTLCTRL.val2 || ' is provided  '|| v_VTLCTRL.val1 || ' should be provided too '' END AS ERRORCODE,
            CASE
                WHEN (A.val IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, 1 val FROM '  ||v_VTLCTRL.tbl_dsd || ' A 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val1 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') A,
               (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, B.* FROM '  ||v_VTLCTRL.tbl_dsd || ' B 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val2 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') B
            WHERE A.KEY(+)=B.KEY';
            execute immediate v_select; 
                        
            v_select:='ALTER TABLE  ' ||v_table_name  ||'  MODIFY ERRORCODE varchar2(2000)';
            execute immediate v_select;              
    else
            v_select:='insert into ' ||v_table_name  ||' SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (B.val IS NULL) THEN ''false'' else ''true'' END  AS BOOL_VAR,
            CASE    
                WHEN (B.val IS NULL) THEN  ''If '|| v_VTLCTRL.val1 || ' is provided  '|| v_VTLCTRL.val2 || ' should be provided too '' END AS ERRORCODE,
            CASE
                WHEN (B.val IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, A.* FROM '  ||v_VTLCTRL.tbl_dsd || ' A 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val1 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') A,
               (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, 1 val FROM '  ||v_VTLCTRL.tbl_dsd || ' B 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val2 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') B
            WHERE A.KEY=B.KEY(+)
            UNION
            SELECT ' || num ||' as ID, '|| v_VTLCTRL.key_list || ', 
            CASE
                WHEN (A.val IS NULL) THEN ''false'' else ''true'' END  AS BOOL_VAR,
            CASE    
                WHEN (A.val IS NULL) THEN  ''If '|| v_VTLCTRL.val2 || ' is provided  '|| v_VTLCTRL.val1 || ' should be provided too '' END AS ERRORCODE,
            CASE
                WHEN (A.val IS NULL) THEN ''ERROR'' END AS ERRORLEVEL, sysdate as VAL_DATE
            FROM 
                (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, 1 val FROM '  ||v_VTLCTRL.tbl_dsd || ' A 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val1 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') A,
               (SELECT ' || REPLACE(v_VTLCTRL.key_list,',','||') || ' AS KEY, B.* FROM '  ||v_VTLCTRL.tbl_dsd || ' B 
                WHERE '  ||v_VTLCTRL.chk_fld1 || '= '''  ||v_VTLCTRL.val2 || ''' and ' || v_VTLCTRL.chk_fld2|| '=''' || v_VTLCTRL.val3 ||''') B
            WHERE A.KEY(+)=B.KEY';
            execute immediate v_select;
            commit;                             
     end if;        

END IF;

   /*
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
       */
END P_VALIDA;