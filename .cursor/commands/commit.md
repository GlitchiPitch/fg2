# /commit Command

**Description:** Performs a complete commit cycle with documentation and game version updates

## Action Sequence

### 1. Documentation Update
* Analyze git changes
* Check and update .dev/CHANGELOG.md
* Update .dev/TODO.md
* Verify other documents in .dev/ are up to date

### 2. Game Version Update

* Increment version in GameVersion.model.json
* Update version number in code (if applicable)
* Check version compatibility

### 3. Analysis and Planning

* Check task status in TODO.md
* Define next development steps
* Assess project progress

### 4. Commit Creation

* Form commit message with new version
* Add all changes to index
* Execute commit with version description
* Commit should be in English

## Commit Format

```
v{X}.{Y}.{Z} - {brief description of changes}

- Change 1
- Change 2
- Next steps: {plan for next version}
```
