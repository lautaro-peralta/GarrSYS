# SAFE Submodule Update Procedure

**CRITICAL:** Follow these steps EXACTLY in order to update submodules without losing any work.

---

## 🎯 Goal

Update `apps/backend` and `apps/frontend` to the latest remote version while preserving ALL local changes (including the PostgreSQL migration changes we just made).

---

## 📋 Pre-Flight Checklist

Before starting, verify:
- [ ] You have Git Bash or similar terminal (Windows)
- [ ] You are in the project root: `TP-Desarrollo-de-Software`
- [ ] You have internet connection (to fetch from remote)
- [ ] You have permissions to push to the submodule repos (if needed)

---

## 🔍 STEP 1: Inspect Current State (DO NOT SKIP)

### 1.1 Check main repository status

```bash
cd "C:\Lautaro\Facultad\Materias\Tercero-ISI\Desarrollo software\TP-Desarrollo-de-Software"

git status
```

**Expected output:**
```
M .gitignore
M Makefile
M README.md
m apps/backend       # 'm' means submodule has changes
m apps/frontend      # 'm' means submodule has changes
D infra/about-infra.md
M infra/docker-compose.yml
?? DEPLOYMENT.md
?? GIT_SUBMODULES_GUIDE.md
?? SAFE_SUBMODULE_UPDATE.md
?? VSCODE_EXTENSIONS.md
?? infra/.env.production.example
?? infra/README.md
```

### 1.2 Check backend submodule status

```bash
cd apps/backend

# Check current branch/commit
git status

# Check what files are modified
git diff --name-status

# Check untracked files
git ls-files --others --exclude-standard
```

**Expected changes:**
- Modified: `package.json`, `pnpm-lock.yaml`, `src/shared/db/orm.config.ts`
- Untracked: `.dockerignore`, `Dockerfile`

### 1.3 Check frontend submodule status

```bash
cd ../frontend

# Check current branch/commit
git status

# Check untracked files
git ls-files --others --exclude-standard
```

**Expected changes:**
- Untracked: `.dockerignore`, `Dockerfile`, `nginx.conf`, `vercel.json`

### 1.4 Return to root

```bash
cd ../..
```

---

## 💾 STEP 2: Save Backend Changes (CRITICAL)

### 2.1 Go to backend submodule

```bash
cd apps/backend
```

### 2.2 Check current commit and branch

```bash
# See current commit
git log --oneline -1

# See current branch (will show "HEAD detached at...")
git branch
```

**Write down the current commit hash** (e.g., `5391272`) - this is your safety backup!

### 2.3 Fetch latest from remote (doesn't change local files)

```bash
# Fetch all branches from remote
git fetch origin

# See what branches exist
git branch -r
```

**Look for:** `origin/main` or `origin/master` (the default branch)

### 2.4 Create a backup branch at current state

```bash
# Create backup at current detached HEAD state
git branch backup-before-update

# Verify backup was created
git branch
```

You should see:
```
* (HEAD detached at 5391272)
  backup-before-update
```

### 2.5 Checkout the main branch

```bash
# Replace 'main' with 'master' if that's the default branch
git checkout main
```

**If you get an error about uncommitted changes, STOP and follow this:**

```bash
# See what files have changes
git status

# Commit the changes FIRST
git add package.json pnpm-lock.yaml src/shared/db/orm.config.ts
git add .dockerignore Dockerfile  # Add untracked files too

git commit -m "Migration: Switch from MySQL to PostgreSQL

- Update package.json to use @mikro-orm/postgresql
- Update orm.config.ts to use PostgreSqlDriver
- Add Dockerfile for containerization"

# NOW checkout main
git checkout main
```

### 2.6 Pull latest changes from remote

```bash
# Pull latest changes from origin/main
git pull origin main
```

**Possible outcomes:**

**A) No conflicts - SUCCESS:**
```
Already up to date.
```
or
```
Updating abc1234..def5678
Fast-forward
...
```

**B) Merge conflicts:**
```
CONFLICT (content): Merge conflict in package.json
Automatic merge failed; fix conflicts and then commit the result.
```

**If you get conflicts, follow Section 5 below before continuing.**

### 2.7 Verify your changes are still there

```bash
# Check package.json still has PostgreSQL
grep "postgresql" package.json

# Check orm.config.ts still has PostgreSqlDriver
grep "PostgreSqlDriver" src/shared/db/orm.config.ts

# Check Dockerfile exists
ls -la | grep Dockerfile
```

**If any of these fail, STOP and ask for help!**

### 2.8 Return to root

```bash
cd ../..
```

---

## 💾 STEP 3: Save Frontend Changes

### 3.1 Go to frontend submodule

```bash
cd apps/frontend
```

### 3.2 Check current commit and create backup

```bash
# See current commit
git log --oneline -1

# Write down commit hash (e.g., 4b86bd1)

# Create backup
git branch backup-before-update

# Fetch latest
git fetch origin

# See default branch
git branch -r
```

### 3.3 Add untracked files and checkout main

```bash
# Check what untracked files exist
git status

# If there are untracked files (.dockerignore, Dockerfile, nginx.conf, vercel.json)
# Add them first
git add .dockerignore Dockerfile nginx.conf vercel.json

# Commit them
git commit -m "Add Docker and deployment configuration files"

# Checkout main
git checkout main
```

### 3.4 Pull latest changes

```bash
git pull origin main
```

### 3.5 Verify files are still there

```bash
# Check that your files still exist
ls -la | grep -E "Dockerfile|nginx.conf|vercel.json"
```

### 3.6 Return to root

```bash
cd ../..
```

---

## 📦 STEP 4: Update Main Repository References

Now the submodules are on the latest commits. We need to tell the main repository about this.

### 4.1 Check main repository status

```bash
# From root of TP-Desarrollo-de-Software
git status
```

**You should see:**
```
modified:   apps/backend (new commits)
modified:   apps/frontend (new commits)
```

This is GOOD! It means the main repo detected the submodules updated.

### 4.2 Add ALL changes (submodules + our fixes)

```bash
# Add everything
git add .

# Verify what will be committed
git status
```

**You should see:**
- Modified: `.gitignore`, `Makefile`, `README.md`, `docker-compose.yml`
- New files: `GIT_SUBMODULES_GUIDE.md`, `SAFE_SUBMODULE_UPDATE.md`, etc.
- Modified submodules: `apps/backend`, `apps/frontend`

### 4.3 Commit everything

```bash
git commit -m "Complete migration from MySQL to PostgreSQL + update submodules

Changes in main repository:
- Updated docker-compose.yml to use PostgreSQL instead of MySQL
- Removed MySQL service from docker-compose.yml
- Updated Makefile documentation (MySQL -> PostgreSQL)
- Updated README.md with PostgreSQL instructions
- Added git submodules documentation

Submodules updated to latest versions:
- apps/backend: Updated to latest main branch
- apps/frontend: Updated to latest main branch

Backend changes (in submodule):
- Migrated from @mikro-orm/mysql to @mikro-orm/postgresql
- Updated orm.config.ts to use PostgreSqlDriver
- Added Docker configuration

Frontend changes (in submodule):
- Added Docker and Nginx configuration
- Added Vercel deployment config"
```

### 4.4 Verify commit was created

```bash
git log --oneline -1
```

You should see your commit message.

---

## 🚀 STEP 5: Push Everything

### 5.1 Push backend submodule changes (if you committed anything)

```bash
cd apps/backend

# Check if you have commits to push
git log origin/main..HEAD

# If there are commits, push them
git push origin main

cd ../..
```

**If you get permission errors:** You may not have push access to the backend repo. That's OK - the commits are safe locally. You can create a PR later.

### 5.2 Push frontend submodule changes (if you committed anything)

```bash
cd apps/frontend

# Check if you have commits to push
git log origin/main..HEAD

# If there are commits, push them
git push origin main

cd ../..
```

### 5.3 Push main repository

```bash
# Push the main repository (this is the most important one)
git push origin main
```

---

## ✅ STEP 6: Verification

### 6.1 Verify submodules are on correct commits

```bash
git submodule status
```

**You should see NO leading '-' or '+' signs, just commit hashes:**
```
 abc1234... apps/backend (heads/main)
 def5678... apps/frontend (heads/main)
```

### 6.2 Verify backend still has PostgreSQL

```bash
cd apps/backend
grep "postgresql" package.json
grep "PostgreSqlDriver" src/shared/db/orm.config.ts
cd ../..
```

Both should return results.

### 6.3 Verify main repository changes

```bash
grep "postgres:" infra/docker-compose.yml
grep "PostgreSQL" README.md
grep "PostgreSQL" Makefile
```

All should return results.

### 6.4 Final status check

```bash
git status
```

**Should show:**
```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

---

## 🆘 STEP 7: Rollback (IF SOMETHING WENT WRONG)

### If backend got messed up:

```bash
cd apps/backend

# Go back to the backup
git checkout backup-before-update

# Check files are back
git status

cd ../..
```

### If frontend got messed up:

```bash
cd apps/frontend

# Go back to the backup
git checkout backup-before-update

cd ../..
```

### If main repository got messed up:

```bash
# See recent commits
git log --oneline -5

# Reset to previous commit (replace abc1234 with actual hash)
git reset --hard abc1234

# Or reset to remote version
git reset --hard origin/main
```

---

## 🔥 SECTION 5: Handling Merge Conflicts

If you got merge conflicts in Step 2.6 or 3.4:

### What are merge conflicts?

Git found the same lines changed both locally and in the remote. You need to decide which version to keep.

### How to resolve:

```bash
# See which files have conflicts
git status

# Open the conflicted file (e.g., package.json)
# Look for conflict markers:
<<<<<<< HEAD
your local changes
=======
remote changes
>>>>>>> origin/main

# Edit the file to keep what you want
# Remove the conflict markers (<<<, ===, >>>)

# After fixing all conflicts:
git add <fixed-file>
git commit -m "Merge remote changes, keeping PostgreSQL migration"
```

### For package.json conflicts:

**Keep your version** (the one with `@mikro-orm/postgresql`), but check if there are new dependencies from remote that you should also include.

---

## 📊 Summary of Safety Measures

This procedure is safe because:

1. ✅ **We created backups** before making any changes (`backup-before-update` branches)
2. ✅ **We committed changes** before pulling from remote
3. ✅ **We used `git pull`** (not `git reset --hard`) to preserve local work
4. ✅ **We verified** at each step that our changes are still there
5. ✅ **We can rollback** to the backup branches if needed

---

## ⏱️ Estimated Time

- If no conflicts: **5-10 minutes**
- If conflicts occur: **15-30 minutes**

---

## 🎯 Quick Checklist

Use this to track your progress:

- [ ] Step 1: Inspected current state
- [ ] Step 2: Saved backend changes
  - [ ] Created backup branch
  - [ ] Committed local changes
  - [ ] Pulled latest from remote
  - [ ] Verified PostgreSQL changes are intact
- [ ] Step 3: Saved frontend changes
  - [ ] Created backup branch
  - [ ] Committed local changes
  - [ ] Pulled latest from remote
  - [ ] Verified files are intact
- [ ] Step 4: Updated main repository
  - [ ] Added all changes
  - [ ] Committed with descriptive message
- [ ] Step 5: Pushed everything
  - [ ] Pushed backend (if applicable)
  - [ ] Pushed frontend (if applicable)
  - [ ] Pushed main repository
- [ ] Step 6: Verified everything works
  - [ ] Submodule status looks correct
  - [ ] PostgreSQL references intact
  - [ ] All files present

---

**DO NOT PROCEED to the next step if any verification fails!**

Ask for help if you get stuck at any point.
