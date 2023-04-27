*** Settings ***
Library           DatabaseLibrary

*** Variables ***
${dbname}         Angelovski
${dbuser}         root
${dbpasswd}       ${EMPTY}
${dbhost}         localhost
${dbport}         3306
@{queryResults}

*** Test Cases ***
TC_0
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    @{queryResults}    Execute Sql String    Call UpdateBrand_byname('de', 'kia')
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END
    Log    Marijana

TC_02
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    @{queryResults}    Query    Select * From models Where model_name='a8'
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END
    Log    Marijana

TC_Delete
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    Execute Sql String    Delete \ From brand Where brand_name='Toyota' and country='jap'
    @{queryResults}    Query    Select * From brand
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END
    Log    Marijana

TC_StoredProcedure
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    @{queryResults}    Query    Call _select_brand ()
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END
    Log    Marijana

TC_sp_insert
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    Execute Sql String    Call _insert_brand ( 'kia', 'sp', 1)
    @{queryResults}    Query    Call _select_brand()
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END

TC_sp_delete
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    Execute Sql String    CALL _delete_brand ('kia', 'de')
    @{queryResults}    Query    Call _select_brand()
    FOR    ${row}    IN    @{queryResults}
        Log    ${row}
    END

TC_brand
    Connect to Database    pymysql    ${dbname}    ${dbuser}    ${dbpasswd}    ${dbhost}    ${dbport}    @{queryResults}
    Execute Sql String    Call _insert_brand ('toyota', 'de', 1)
    @{queryResults1}    Execute Sql String    Call _select_brand()
    FOR    ${row}    IN    @{queryResults1}
        Log    ${row}
    END
    Execute Sql String    Call _update_brand('citroen', 'fr', 12)
    Execute Sql String    Call _delete_brand('opel', 'de')
    @{queryResults2}    Execute Sql String    Call _select_brand()
    FOR    ${row}    IN    @{queryResults2}
        Log    ${row}    ${row}
    END
