procedure add3DVars(varNames,fin,fout,dim_time, dim_lat, dim_lon) begin
    ; Iterate over all the files and add each variable
    do varIdx =0,dimsizes(varNames)-1,1 ; This loop iterates over the variables
        print("Adding "+varNames(varIdx)+"...")
        origVar = fin->$varNames(varIdx)$
printVarSummary(origVar)
printVarSummary(dim_time)
printVarSummary(dim_lat)
printVarSummary(dim_lon)
        newVar = new((/dim_time,dim_lat, dim_lon/), "float", 0)
printVarSummary(newVar)
        newVar(:,:,:) = (/origVar/)

		; ---- Copy the original variables 
        ;copy_VarAtts(origVar,newVar) ; Copy origial attributes
        ;delete_VarAtts(newVar, (/"coordinates"/))

        filevardef(fout, varNames(varIdx) ,typeof(newVar), (/"Latitude","Longitude","Time" /) ) ; time dimension

        filevarattdef(fout,varNames(varIdx),newVar); copy T attributes
        fout->$varNames(varIdx)$ = (/newVar/)
        delete(newVar)
        delete(origVar)
        print("Done!")
    end do
end