CREATE TABLE public.medical_histories
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    admited_at timestamp with time zone,
    patient_id integer,
    status text,
    CONSTRAINT pk_medical_histories PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_histories
    OWNER to postgres;

COMMENT ON TABLE public.medical_histories
    IS 'Create medical_histories';

CREATE TABLE public.patients
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text,
    date_of_birth date,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.patients
    OWNER to postgres;

COMMENT ON TABLE public.patients
    IS 'Create patients table.';
    
    CREATE TABLE public.invoice_items
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    unit_price numeric,
    quantity integer,
    total_price numeric,
    invoice_id integer,
    treatment_id integer,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice_items
    OWNER to postgres;

COMMENT ON TABLE public.invoice_items
    IS 'create invoice_items table';
    
    CREATE TABLE public.invoice
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    total_amount numeric,
    generated_at timestamp with time zone,
    payed_at timestamp with time zone,
    medical_history_id integer,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice
    OWNER to postgres;

COMMENT ON TABLE public.invoice
    IS 'create invoice table';
