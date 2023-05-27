DROP FUNCTION IF EXISTS contains_only_latin_letters_spaces_dashes CASCADE;
CREATE FUNCTION contains_only_latin_letters_spaces_dashes(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '[A-Za-z -]*' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% value should consist of latin letters, spases and dashes only', table_name, field_name;
END; $$
LANGUAGE plpgsql
IMMUTABLE;

DROP FUNCTION IF EXISTS starts_with_capitalised_latin_letter CASCADE;
CREATE FUNCTION starts_with_capitalised_latin_letter(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '[A-Z]%' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% value should starts with capitalized latin letter', table_name, field_name;
END; $$
LANGUAGE plpgsql
IMMUTABLE;

DROP FUNCTION IF EXISTS has_email_format CASCADE;
CREATE FUNCTION has_email_format(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '([^@]*)@(([^@]+).+)([^@.]+)' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% value should correspond the next pattern: <login>@...<secondleveldomain>.<firstleveldomain>', table_name, field_name;
END; $$
LANGUAGE plpgsql
IMMUTABLE;

DROP FUNCTION IF EXISTS has_correct_login CASCADE;
CREATE FUNCTION has_correct_login(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '([a-zA-Z0-9.!?#$%&+/=^_`’{|}~½-]+)@%' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% : login can consist of the characters a-zA-Z0-9.!?#$&+/=^_`’{|}~½-', table_name, field_name; --fix %
END; $$
LANGUAGE plpgsql
IMMUTABLE;

DROP FUNCTION IF EXISTS has_correct_nleveldomain CASCADE;
CREATE FUNCTION has_correct_nleveldomain(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '([^@]*)@(([a-zA-Z0-9-]+).+)([^@.]+)' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% : nleveldomain can consist of the characters [a-zA-Z0-9-] and should not be empty', table_name, field_name;
END; $$
LANGUAGE plpgsql
IMMUTABLE;

DROP FUNCTION IF EXISTS has_correct_firstleveldomain CASCADE;
CREATE FUNCTION has_correct_firstleveldomain(
    str VARCHAR, table_name VARCHAR, field_name VARCHAR)
    RETURNS BOOLEAN
AS $$
BEGIN
    IF str SIMILAR TO '([^@]*)@(([^@]+).+)([a-zA-Z0-9]-*)([a-zA-Z0-9]+)' THEN
        RETURN TRUE;
    END IF;
    RAISE '%.% : firstleveldomain can consist of the characters [a-zA-Z0-9-] and should end with [a-zA-Z0-9]', table_name, field_name;
END; $$
LANGUAGE plpgsql
IMMUTABLE;

