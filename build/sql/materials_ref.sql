-- Function: public.materials_ref(materials)

-- DROP FUNCTION public.materials_ref(materials);

CREATE OR REPLACE FUNCTION public.materials_ref(materials)
  RETURNS json AS
$BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','materials'
	);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.materials_ref(materials)
  OWNER TO rustent;

