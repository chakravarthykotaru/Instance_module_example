resource "aws_instance" "server" {
    ami = "${lookup(var.ami, "${var.region}-${var.platform}")}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    count = "${var.servers}"

    connection {
        user = "${lookup(var.user, var.platform)}"
        private_key = "${file("${var.key_path}")}"
    }

    #Instance tags
    tags {
        Name = "${var.tagName}-${count.index}"
        ConsulRole = "Server"
    }

    provisioner "file" {
        source = "${path.module}/shared/scripts/a.sh"
        destination = "/tmp/a.sh"
    }


    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/a.sh",
            "sudo /tmp/a.sh",
        ]
    }
}

