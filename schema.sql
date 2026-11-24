-- Spustit v Supabase → SQL Editor. Změň e-mail na svůj.
create table public.events (
  id bigint generated always as identity primary key,
  t  timestamptz not null default now(),
  v  smallint not null check (v between 1 and 10)
);

alter table public.events enable row level security;

-- kdokoliv (anon) smí jen ZAPSAT
create policy "w" on public.events for insert to anon, authenticated with check (true);

-- číst smí jen přihlášený vlastník
create policy "r" on public.events for select to authenticated
  using ((auth.jwt() ->> 'email') = 'TVUJ@EMAIL');

-- doporučeno: Authentication → Providers → Email → vypnout "Allow new users to sign up"
