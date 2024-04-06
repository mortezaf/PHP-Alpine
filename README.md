## Dockerfile for PHP 8.3 with Nginx & Roadrunner

This Dockerfile provides a lightweight container environment for PHP 8.3 along with Nginx and Roadrunner, based on Alpine Linux 3.19. It's suitable for various PHP projects including Laravel, Symfony, and Lumen.

### Features
- PHP 8.3 with essential extensions for web development.
- Nginx server for handling web requests.
- Roadrunner for efficient PHP application serving.
- Supervisor for process control and monitoring.
- Composer and other PHP tools pre-installed.
- Customizable configuration for Nginx, PHP, and Supervisor.

### Usage
1. Clone this repository.

2. Build the Docker image:
    ```bash
    docker build -t php-nginx-roadrunner .
    ```

3. Run the container:
    ```bash
    docker run -p 8080:8080 php-nginx-roadrunner
    ```

4. Access your PHP application at `http://localhost:8080`.

### Customization
- Modify `nginx.conf` in `.docker/dev/config/` to adjust Nginx configuration.
- Customize PHP settings by editing `php.ini` in `.docker/dev/config/`.
- Modify `supervisord.conf` in `.docker/dev/config/` for Supervisor process management.
- Adjust the `docker-entrypoint.sh` script in `.docker/dev/` for any specific requirements of your project.

### Directory Structure
- `.docker/dev/config/`: Contains configuration files for Nginx, PHP, and Supervisor.
- `.docker/dev/docker-entrypoint.sh`: Entrypoint script for initializing the container.
- `app/`: Your PHP project files should be placed here.

### Note
- Ensure your PHP project dependencies are specified in a `composer.json` file, and if using Node.js, ensure a `package.json` is present for `npm install` to work properly.
- Make sure to adjust the Dockerfile according to your project's requirements.

### Maintainer
- **Morteza Fathi** - mortezaa.fathi@gmail.com

### Contributions
Contributions are welcome! If you find any issues or improvements, feel free to open a pull request.

### License
This Dockerfile is licensed under the [MIT License](LICENSE).
