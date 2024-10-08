This action is a fork of the [Akamai Purge Action](https://github.com/jdmevo123/akamai-purge-action). 

We addressed several issues from the original, such as the limitation of only selecting a single reference, which made it difficult to purge multiple CP codes simultaneously.


# Purge Akamai Cache   

This simple action calls the Akamai Api's to purge the cache of your website, which assists in clearing the cache after deploying a new application version.

## Usage

All sensitive variables should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) in the action's configuration.

## Authentication

You need to declare a `EDGERC` secret in your repository containing the following structure :
```
[ccu]
client_secret = your_client_secret
host = your_host
access_token = your_access_token
client_token = your_client_token
```
You can retrieve these from Akamai Control Center >> Identity Management >> API User.

## Inputs

### `command`
**Required**
Purge action you wish to run:
- invalidate : Invalidate all cache on the Akamai edge platform
- delete : Delete(remove) all cache from the Akamai edge platform
* Note: use caution when deleting all cache from the Akamai edge platform

### `type`
**Required**
Type of purge required:
- cpcode : Purge by cpcode
- tag : Purge by Cache Tag
- url : Purge by url

### `ref`
**Required**  
One or more CP codes, cache tags, or URLs to purge, separated by spaces.

## `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
- name: Clear Cache
      uses: Evolane/akamai-purge-action@1.0
      env:
        EDGERC: ${{ secrets.EDGERC }}
      with:
        command: 'delete' 
        type: 'cpcode' #valid inputs are 'cpcode', 'url' and 'tag'
        ref: '12345'  # Input one or more values, separated by a space. Ensure you use quotes here.
        network: 'production'
```
## License

This project is distributed under the [MIT license](LICENSE.md).
