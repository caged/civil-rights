all: data/csv/in_school_suspension.csv \
	data/csv/referral_to_law_enforcement.csv \
	data/csv/expulsions_without_educational_services.csv \
	data/csv/more_than_one_out_of_school_suspension.csv \
	data/csv/one_or_more_out-of-school_suspensions.csv \
	data/csv/corporal_punishment.csv \
	data/csv/expulsions_with_educational_services.csv \
	data/csv/only_one_out-of-school_suspension.csv \
	data/csv/school-related_arrests.csv \
	data/csv/expulsions_under_zero_tolerance_policies.csv \
	data/csv/expulsions_with_and_without_educational_services.csv

.SECONDARY:

data/xlsx/%.xlsx:
	mkdir -p $(dir $@)
	curl -L --remote-time 'http://ocrdata.ed.gov/downloads/projections/2011-12/discipline/$(notdir $(subst _,%20, $@))' -o $@.download
	mv $@.download $@

data/csv/in_school_suspension.csv: data/xlsx/One_or_more_in-school_suspensions.xlsx
data/csv/referral_to_law_enforcement.csv: data/xlsx/Referral_to_law_enforcement.xlsx
data/csv/expulsions_without_educational_services.csv: data/xlsx/Expulsions_without_educational_services.xlsx
data/csv/more_than_one_out_of_school_suspension.csv: data/xlsx/More_than_one_out_of_school_suspension.xlsx
data/csv/one_or_more_out-of-school_suspensions.csv: data/xlsx/One_or_more_out-of-school_suspensions.xlsx
data/csv/corporal_punishment.csv: data/xlsx/Corporal_Punishment.xlsx
data/csv/expulsions_with_educational_services.csv: data/xlsx/Expulsions_with_educational_services.xlsx
data/csv/only_one_out-of-school_suspension.csv: data/xlsx/Only_one_out-of-school_suspension.xlsx
data/csv/school-related_arrests.csv: data/xlsx/School-related_arrests.xlsx
data/csv/expulsions_under_zero_tolerance_policies.csv: data/xlsx/Expulsions_under_zero_tolerance_policies.xlsx
data/csv/expulsions_with_and_without_educational_services.csv: data/xlsx/Expulsions_with_and_without_educational_services.xlsx

data/csv/%.csv: data/xlsx/%.xlsx script/csv-from-xlsx
	mkdir -p $(dir $@)
	ruby script/csv-from-xlsx $@ $(word 3,$^)
