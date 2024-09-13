# Setup MSSQL Action

This GitHub action automatically installs a SQL server and `sqlcmd` on Windows and Linux.

On Windows, we install an Express edition of the container. On Linux, a Docker container is started. `sqlcmd` is actually preinstalled on all Windows images as well as Ubuntu 20.04 and 22.04. Essentially, it only has an effect on Ubuntu 24.04.

## Usage

### Inputs

* `components`: Specify the components you want to install. Can be `sqlengine` and `sqlcmd`.
* `force-encryption`: When you request to install `sqlengine`, you can set this input to `true` in order to encrypt all connections to the SQL server. The action will generate a self-signed certificate for that. Default is `false`.
* `sa-password`: The sa password for the SQL instances. Default is `bHuZH81%cGC6`.
* `version`: Version of the SQL server you want to install (2017, 2020 or 2022).

## License

The scripts and documentation in this project are released under the MIT License.

## Credits

Inspiration for the action came from https://github.com/marketplace/actions/mssql-suite.
