# women_in_mathematics using dagster

## Getting started

### Installing dependencies

We're gonna use `uv`. Ensure [`uv`](https://docs.astral.sh/uv/) is installed following their [official documentation](https://docs.astral.sh/uv/getting-started/installation/).

Create a virtual environment, and install the required dependencies using _sync_:

```bash
uv sync
```

Then, activate the virtual environment: `source .venv/bin/activate`

### Running Dagster

**Option 1: Using the Dagster UI**

Start the Dagster UI web server:

```bash
dg dev
```

Open http://localhost:3000 in your browser to see the project and materialize assets.

**Option 2: Using the CLI**

Set your OpenAI API key:

```bash
export OPENAI_API_KEY="your-key-here"
```

List all available assets:

```bash
dagster asset list -m women_in_mathematics -a defs
```

Materialize a single asset:

```bash
dagster asset materialize -m women_in_mathematics -a defs --select split_pdfs
```

Materialize all assets (there must be an easier to do that...):

```bash
dagster asset materialize -m women_in_mathematics -a defs --select "*"
```

### Pipeline Assets Structure

We keep the same structure than `PDP`, but we add some scaffolding because dagster understand projects a bit like package. So we have that `src/women_in_mathematics` python package structure. Then we have two extra files: (i) `definition.py` that find all the "assets" (or tasks), and (ii) `resources.py` that define external resources, such as openAI client in this case.

```
.                                                  
├── pyproject.toml                                 
├── README.md                                      
├── src                                            
│   └── women_in_mathematics                       
│       ├── __init__.py                            
│       ├── definitions.py                         
│       └── defs                                   
│           ├── __init__.py                        
│           ├── analyze                            
│           │   ├── note                           
│           │   │   └── women_in_mathematics.ipynb 
│           │   └── output                         
│           │       └── employment_with_dates.csv  
│           ├── extract                            
│           │   ├── Makefile                       
│           │   ├── output                         
│           │   └── src                            
│           │       └── extract_assets.py          
│           ├── join                               
│           │   ├── output                               
│           │   └── src                            
│           │       └── join_assets.py             
│           ├── parse                              
│           │   ├── output                         
│           │   ├── README.md                      
│           │   └── src                            
│           │       └── parse_assets.py            
│           ├── resources.py                       
│           ├── split                              
│           │   ├── input                          
│           │   ├── output                         
│           │   ├── README.md                      
│           │   ├── src                            
│           │   │   └── split_assets.py            
│           │   └── unused_pages                   
│           └── tests                              
│               └── __init__.py                    
└── uv.lock                                        
```


### Asset Caching

All assets use Dagster's versioning system to avoid redundant work:
- Assets are versioned (currently all at `v1`)
- Dagster automatically detects when results would be identical to previous runs
- Unchanged assets are skipped, saving time and API costs (especially for GPT-4o calls)
- Update the `code_version` in the asset decorator when you modify the logic