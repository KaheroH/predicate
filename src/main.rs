use predicate::learning;

fn main() -> anyhow::Result<()> {
    learning::run()?;
    Ok(())
}
